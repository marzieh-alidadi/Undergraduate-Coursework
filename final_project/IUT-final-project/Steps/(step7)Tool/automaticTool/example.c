int main()
{
	while(1)
		f1();

	return 0;
}
int f1()
{
	int i;
	for(i = 1; i < 10; i++)
		f2();

	return 0;
}
int f2()
{
	f3();
	return 0;
}
int f3()
{
	f1();
	return 0;
}
