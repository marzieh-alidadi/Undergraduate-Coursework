// Generated by MODEX Version 2.11 - 3 November 2017
// ‫جۆمعه ۱۰ سپتامبر ۲۱، ساعات ۱۷:۲۲:۴۱ (+0430)‬ from example.c

int res_p_f3;
bool lck_p_f3_ret;
bool lck_p_f3;
int res_p_f2;
bool lck_p_f2_ret;
bool lck_p_f2;
int res_p_f1;
bool lck_p_f1_ret;
bool lck_p_f1;
int res_p_main;
bool lck_p_main_ret;
bool lck_p_main;
chan ret_p_f3 = [1] of { pid };
chan exc_cll_p_f3 = [0] of { pid };
chan req_cll_p_f3 = [1] of { pid };
chan ret_p_f2 = [1] of { pid };
chan exc_cll_p_f2 = [0] of { pid };
chan req_cll_p_f2 = [1] of { pid };
chan ret_p_f1 = [1] of { pid };
chan exc_cll_p_f1 = [0] of { pid };
chan req_cll_p_f1 = [1] of { pid };
chan ret_p_main = [1] of { pid };
chan exc_cll_p_main = [0] of { pid };
chan req_cll_p_main = [1] of { pid };
active proctype p_main()
{
pid lck_id;
L_0:
    do
    :: true;
 atomic {
  lck_p_f1 == 0 && empty(req_cll_p_f1) -> req_cll_p_f1!_pid;
  exc_cll_p_f1!_pid;
 }
 ret_p_f1?eval(_pid);
 c_code { ; now.lck_p_f1_ret = 0; };
    goto L_0;
    :: c_expr { !1 }; -> break
    od;
     atomic { !lck_p_main_ret -> lck_p_main_ret = 1 };
 c_code { now.res_p_main = (int ) 0; }; goto Return;
Return: skip;
}
active proctype p_f1()
{
int i;
pid lck_id;
endRestart:
 atomic {
 nempty(req_cll_p_f1) && !lck_p_f1 -> lck_p_f1 = 1;
 req_cll_p_f1?lck_id; exc_cll_p_f1?eval(lck_id);
 lck_p_f1 = 0;
 };
    c_code { Pp_f1->i=1; };
L_1:
    do
    :: c_expr { (Pp_f1->i<10) };
 atomic {
  lck_p_f2 == 0 && empty(req_cll_p_f2) -> req_cll_p_f2!_pid;
  exc_cll_p_f2!_pid;
 }
 ret_p_f2?eval(_pid);
 c_code { ; now.lck_p_f2_ret = 0; };
c_code { Pp_f1->i++; };
    goto L_1;
c_code { Pp_f1->i++; };
    :: c_expr { !(Pp_f1->i<10) }; -> break
    od;
     atomic { !lck_p_f1_ret -> lck_p_f1_ret = 1 };
 c_code { now.res_p_f1 = (int ) 0; }; goto Return;
Return: skip;
 ret_p_f1!lck_id;
 goto endRestart
}
active proctype p_f2()
{
pid lck_id;
endRestart:
 atomic {
 nempty(req_cll_p_f2) && !lck_p_f2 -> lck_p_f2 = 1;
 req_cll_p_f2?lck_id; exc_cll_p_f2?eval(lck_id);
 lck_p_f2 = 0;
 };
 atomic {
  lck_p_f3 == 0 && empty(req_cll_p_f3) -> req_cll_p_f3!_pid;
  exc_cll_p_f3!_pid;
 }
 ret_p_f3?eval(_pid);
 c_code { ; now.lck_p_f3_ret = 0; };
     atomic { !lck_p_f2_ret -> lck_p_f2_ret = 1 };
 c_code { now.res_p_f2 = (int ) 0; }; goto Return;
Return: skip;
 ret_p_f2!lck_id;
 goto endRestart
}
active proctype p_f3()
{
pid lck_id;
endRestart:
 atomic {
 nempty(req_cll_p_f3) && !lck_p_f3 -> lck_p_f3 = 1;
 req_cll_p_f3?lck_id; exc_cll_p_f3?eval(lck_id);
 lck_p_f3 = 0;
 };
 atomic {
  lck_p_f1 == 0 && empty(req_cll_p_f1) -> req_cll_p_f1!_pid;
  exc_cll_p_f1!_pid;
 }
 ret_p_f1?eval(_pid);
 c_code { ; now.lck_p_f1_ret = 0; };
     atomic { !lck_p_f3_ret -> lck_p_f3_ret = 1 };
 c_code { now.res_p_f3 = (int ) 0; }; goto Return;
Return: skip;
 ret_p_f3!lck_id;
 goto endRestart
}
