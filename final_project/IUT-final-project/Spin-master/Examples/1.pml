// Generated by MODEX Version 2.11 - 3 November 2017
// ‫شنبه ۱۱ سپتامبر ۲۱، ساعات ۱۲:۲۱:۵۰ (+0430)‬ from 1_bounds.c

int res_p_main;
bool lck_p_main_ret;
bool lck_p_main;
int par0_test;
int par1_test;
int res_p_test;
bool lck_p_test_ret;
bool lck_p_test;
chan ret_p_main = [1] of { pid };
chan exc_cll_p_main = [0] of { pid };
chan req_cll_p_main = [1] of { pid };
chan ret_p_test = [1] of { pid };
chan exc_cll_p_test = [0] of { pid };
chan req_cll_p_test = [1] of { pid };
active proctype p_test( )
{
pid lck_id;
int b;
int a;
endRestart:
 atomic {
 nempty(req_cll_p_test) && !lck_p_test -> lck_p_test = 1;
 req_cll_p_test?lck_id; exc_cll_p_test?eval(lck_id);
 c_code { Pp_test->b = now.par1_test; };
 c_code { Pp_test->a = now.par0_test; };
 lck_p_test = 0;
 };
    if
    :: c_expr { (Pp_test->a>=Pp_test->b) };
         atomic { !lck_p_test_ret -> lck_p_test_ret = 1 };
 c_code { now.res_p_test = (int ) Pp_test->a; }; goto Return;
    :: c_expr { !(Pp_test->a>=Pp_test->b) };
       atomic { !lck_p_test_ret -> lck_p_test_ret = 1 };
 c_code { now.res_p_test = (int ) Pp_test->b; }; goto Return;
 fi;
Return: skip;
 ret_p_test!lck_id;
 goto endRestart
}
active proctype p_main()
{
int y = 3;
int x = 2;
pid lck_id;
 atomic {
  lck_p_test == 0 && empty(req_cll_p_test) -> req_cll_p_test!_pid;
  c_code { now.par0_test = Pp_main->x; };
  c_code { now.par1_test = Pp_main->y; };
  exc_cll_p_test!_pid;
 }
 ret_p_test?eval(_pid);
  atomic { !lck_p_main_ret -> lck_p_main_ret = 1 };
 c_code { now.res_p_main = (int ) ; now.lck_p_test_ret = 0; }; goto Return;
Return: skip;
}
