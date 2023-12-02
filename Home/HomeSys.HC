#include "~/Theme.HC"

U0 NewDay(U8 *dir) {
  DirMk(dir);
  Copy("~/AOC23/Template.HC", dir);
  Cd(dir);
  Move("Template.HC", "Main.HC");
  Ed("Main.HC");
}

U0 UserStartUp()
{//Run each time a user a spawned
  DocTermNew;
  Type("::/Doc/Start.DD");
  LBts(&Fs->display_flags,DISPLAYf_SHOW);
  WinToTop;
  WinZBufUpdate;
  Dir;
}

U0 SrvStartUp()
{//Run each time a srv task is spawned.
  DocTermNew;
  LBts(&Fs->display_flags,DISPLAYf_SHOW);
  WinToTop;
  WinZBufUpdate;
}

U0 StartUpTasks()
{
  CTask *user1;
  user1=User;
  WinMax(user1);
  "Boot Time:%7.3fs\n",tS;
  XTalk(user1,"Cd(\"AOC23/\");\nDir;\n");
  Silent;	//no output to scrn
  ACInit("/*;!*/Bible.TXT*");
  Silent(OFF); //no output to scrn
}

StartUpTasks;

"\nTempleOS V%5.3f\t%D %T\n\n",sys_os_version,sys_compile_time,sys_compile_time;
