#include <stdio.h>
#include "forth.h"
#include "prims.h"
#include "compiler.h"

extern void exit();
int strlen(const char *);

char *infile;   // e.g. "interp.fth"
char *outfile;  // e.g. "kernel.dic"

cell stack;	/* One-element stack, used for arguments to `constant' */

cell variables[MAXVARS];

main(argc, argv)
    int argc;
    char **argv;
{
    extern void init_dictionary(cell *up);
    u_char *origin;

    if (argc != 3) {
        fprintf(stderr, "usage: meta input-file-name output-file-name\n");
        exit(1);
    }
    infile = argv[1];
    outfile = argv[2];

    origin = aln_alloc(MAXDICT, variables);
    init_compiler(origin, origin+MAXDICT, 0xfffe, origin, origin+MAXDICT, variables);
    init_dictionary(variables);
}


void
init_dictionary(cell *up)
{
    /* reserve space for an array of tokens to the cfa of prim headers */
    V(DP) += (MAXPRIM * sizeof(token_t));

#if 0
    // Make a temporary vocabulary structure so header will have
    // a place to put its various links

    tokstore(CT_FROM_XT((xt_t)V(DP), up), &V(CONTEXT));
    tokstore(CT_FROM_XT((xt_t)V(DP), up), &V(CURRENT));

    linkcomma(DOVOC);
    linkcomma(CT_FROM_XT(V(TORIGIN), up));
    linkcomma(CT_FROM_XT(V(TORIGIN), up));

    /* Make the initial dictionary entry */
    header("forth", sizeof("forth")-1);
#else
    place_name("forth", sizeof("forth")-1, CT_FROM_XT((xt_t)V(TORIGIN), up), up);
#endif

    // Install the new vocabulary in the search order and the vocabulary list
    tokstore(CT_FROM_XT((xt_t)V(DP), up), (xt_t)&V(CONTEXT));
    tokstore(CT_FROM_XT((xt_t)V(DP), up), (xt_t)&V(CURRENT));
    tokstore(CT_FROM_XT((xt_t)V(DP), up), (xt_t)&V(VOC_LINK));

    compile((token_t)DOVOC);  // Code field

#ifdef RELOCATE
    set_relocation_bit(V(DP));
#endif
#if 0
    linkcomma(T(LASTP));    // last-word field
#else
    unumcomma(0);           // Forth voc threads are first thing in user area
    *(xt_t)(&up[0]) = T(LASTP);
#endif

    linkcomma(CT_FROM_XT((xt_t)V(TORIGIN), up));  // voc-link field

    init_variables(sizeof(cell), up);    // arg is first avail user number
    init_entries(up);
}


#define META_PS_SIZE 10
cell ps[META_PS_SIZE];

cell *xsp;

int next_prim = 1;

init_entries(cell *up)
{
    xsp = &ps[META_PS_SIZE];
    name_input(INIT_FILENAME);

    while (1) {
    	query(up);
        cinterpret(up);
    }
}

init_variables(int unum, cell *up)
{
    V(TO_IN) = V(BLK) = V(NUM_SOURCE) = 0;
    V(NUM_USER) = unum;
    V(NUM_OUT) = V(NUM_LINE) = 0;
    V(BASE) = 10;
    V(TICK_ACCEPT) = SYS_ACCEPT;
#ifdef XXX
    V(TICK_INTERPRET) = SYS_INTERPRET;
#endif
    V(STATE) = INTERPRETING;
    V(WARNING) = 1;
    V(DPL) = -1;
    V(CAPS) = -1;
    V(THISDEF) = 0;
    V(COMPLEVEL) = 0;
    V(LESSIP) = V(CNT) = 0;
}

/*
 * This simplified interpreter has no interpret state.
 * Everything that can be "interpreted" as opposed to "compiled"
 * is "magic", and is executed directly by this metacompiler.
 * It doesn't handle numbers either.
 */
interpret_word(u_char *adr, cell len, cell *up)
{
    char strbuf[32];
    char *cstr = altocstr((char *)adr, len, strbuf, 32);
    xt_t xt;
    token_t pct;
    int immed;
    int number;

    if (ismagic(cstr, up))
        return(1);

    if (alfind((char *)adr, len, (xt_t *)&xt, up) != 0) {
        /*
         * If the word we found is a primitive, use its primitive number
         * instead of its cfa
         */
        pct = *(token_t *)xt;
        compile ( pct < MAXPRIM ? pct : CT_FROM_XT(xt, up) );
        return(1);
    }
    
    if (sscanf(cstr,"%d",&number) == 1) {
        if (V(STATE)) {
            compile(PAREN_LIT);
            ncomma(number);
        } else {
            stack = number;
        }
        return(1);
    }

    /* Undefined */
    alerror((char *)adr, len, up);
    FTHERROR(" ?\n");
    return(0);
}

cinterpret(cell *up)
{
    u_char *thisword;
    cell len;

    while ( ((len = parse_word(&thisword, up)) != 0)
            && interpret_word(thisword, len, up) ) {
    }
}

int
query(cell *up)
{
    V(NUM_SOURCE) = caccept((char *)V(TICK_SOURCE), (cell)TIBSIZE, up);
    V(TO_IN) = 0;
}

/* Place a string in the dictionary */
void
alcomma_string(u_char *adr, cell len, cell *up)
{
    register u_char *rdp = (u_char *)V(DP);

    *rdp++ = (u_char)len;
    while ( len-- )
        *rdp++ = *adr++;
    *rdp++ = '\0';
    /* Pointer alignment */
    V(DP) = (cell)rdp;
    align(up);
}

#define forw_mark    *--xsp = V(DP); V(DP) += sizeof(branch_t);
#define back_mark    *--xsp = V(DP);
#define forw_resolve {	u_char *start = (u_char *)(*xsp++); \
			*(branch_t *)start = V(DP)-(cell)start; }
#define back_resolve {	u_char *start = (u_char *)*xsp++; \
			*(branch_t *)V(DP) = (cell)start-V(DP); \
			V(DP) += sizeof(branch_t); }
#define but	     { cell temp = xsp[0]; xsp[0] = xsp[1]; xsp[1] = temp; }

/* We let the interpreter take care of the next word for ['] and [compile] */
/* This wouldn't work in a "real" Forth interpreter because */
/* the next word could be immediate, but this simplified */
/* metacompiler is only intended to compile very limited code */

void doprim(cell *up)
{
	create_word((token_t)next_prim, up);
    tokstore(T(LASTP), (xt_t)V(TORIGIN) + next_prim);
//  tokstore(T(LASTP), XT_FROM_CT(next_prim*sizeof(token_t)));  // For &data[] version
//  tokstore(T(LASTP), XT_FROM_CT(next_prim)));  // For &tokens[] version

//	tokstore(CT_FROM_XT(V(DP) - sizeof(token_t)), &tokens[next_prim]);
	next_prim++;
}

void doiprim(cell *up)	   { doprim(up); makeimmediate(up); }

void doimmed(cell *up)	   { makeimmediate(up); }
void donuser(cell *up)
{
	create_word((token_t)DOUSER, up);
	unumcomma(V(NUM_USER));
	V(NUM_USER) += sizeof(cell);
}

void dotuser(cell *up)
{
	create_word((token_t)DOUSER, up);
	unumcomma(V(NUM_USER));
	V(NUM_USER) += sizeof(cell);
}

void dodefer(cell *up)
{
	create_word((token_t)DODEFER, up);
	unumcomma(V(NUM_USER));
	V(NUM_USER) += sizeof(cell);
}

void doconstant(cell *up)
{
	create_word((token_t)DOCON, up);
	ncomma(stack);
}

void docftok(cell *up)
{
	create_word((token_t)DOCON, up);
    ncomma(next_prim);  // Don't do ++ here because ncomma has side effects
    ++next_prim;  // 
}

void doload(cell *up)
{
	V(BOUNDARY) = V(DP) - V(TORIGIN);
	V(NUM_USER) = NEXT_VAR*sizeof(cell);
	name_input(infile);
}

void dostore(cell *up)	   {
    xt_t xt;
    cell adr;
    cell len;
    
    write_dictionary(outfile, strlen(outfile), (char *)V(TORIGIN), V(DP)-V(TORIGIN), (char *)up, V(NUM_USER));
    exit(0);
}
void dodotquote(cell *up)  {
    cell adr;
    cell len;
    compile(P_DOT_QUOTE);
    len = parse('"', &adr, up);
    alcomma_string((u_char *)adr, len, up);
}

void doparen(cell *up)     { cell adr; (void) parse(')', &adr, up);  }
void dobackslash(cell *up) { cell adr; (void) parse('\n', &adr, up); }
void dobractick(cell *up)  { compile(PAREN_TICK); }
void dobraccomp(cell *up)  { }
void docolon(cell *up)     { create_word((token_t)DOCOLON, up); V(STATE) = 1;}
void dosemicol(cell *up)   { compile(UNNEST); V(STATE) = 0;}
void doif(cell *up)        { compile(QUES_BRANCH); forw_mark; }
void doelse(cell *up)      { compile(PBRANCH); forw_mark;  but;  forw_resolve; }
void dothen(cell *up)      { forw_resolve; }
void dobegin(cell *up)     { back_mark; }
void dowhile(cell *up)     { compile(QUES_BRANCH); forw_mark; but; }
void dorepeat(cell *up)    { compile(PBRANCH); back_resolve; forw_resolve; }
void doagain(cell *up)     { compile(PBRANCH); back_resolve; }
void dountil(cell *up)     { compile(QUES_BRANCH); back_resolve; }

struct metatab {  char *name; void (*func)(); } metawords[] = {
	"(",		doparen,
	"\\",		dobackslash,
	"[']",		dobractick,
	"[compile]",	dobraccomp,
	":",		docolon,
	";",		dosemicol,
	"immediate",	doimmed,
	"nuser",	donuser,
	"defer",	dodefer,
	"constant",	doconstant,
	"if",		doif,
	"else",		doelse,
	"then",		dothen,
	"begin",	dobegin,
	"while",	dowhile,
	"repeat",	dorepeat,
	"again",	doagain,
	"until",	dountil,
	".\"",		dodotquote,
	"p",		doprim,
	"u",		donuser,
	"t",		dotuser,
	"i",		doiprim,
	"c",		docftok,
	"w",		dostore,
	"e",		doload,
	"",		0,
};

int
ismagic(char *str, cell *up)		/* Returns true if string was handled "magically" */
{
    struct metatab *p;

    for (p = metawords; p->name[0] != '\0'; p++) {
	if (strcmp(str, p->name) == 0) {
	    (p->func)(up);
	    return(1);
	}
    }
    return(0);
}

/* The metacompiler doesn't need interactive mode so we stub these out */
keymode() {}
linemode() {}
/* ARGSUSED */
int find_local(char *adr, int plen, xt_t *xtp, cell *up) { return 0; }

