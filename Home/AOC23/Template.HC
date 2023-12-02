Cd(__DIR__);
#include "~/AOC23/Common.HC"

#if 1
#define INPUT_FILE "sample.TXT"
#else
#define INPUT_FILE "input.TXT"
#endif

U0 Part1()
{
    SV sv;
    sv.begin = FileRead(INPUT_FILE, &sv.size);
    U8 *saved_begin = sv.begin;

    //while (sv.size > 1) {
    //    
    //}

    Free(saved_begin);
}

U0 Part2()
{
}

Part1;
