// txt


#include<stdio.h>
#include<string.h>

struct tarakonesh//structure baraye tarakonesh haye akhir
{
	char date[9];
	double mablagh;
	int  typeOfTarakonesh;//1=bardasht-------------2=variz
};

struct atm
{
	unsigned int cardNo;
	unsigned int pass;
	char name[51];
	double accounts;
	struct tarakonesh eachTarakonesh[20];
	int j = -1;//shomarande baraye tarakonesh ha
}eachCard[90];

int main()
{
	printf("*Tavajoh!\n*Ghabl az ejraye dobareye barname, az file etela'at yek copy bardarid.\n*Chera ke pas az ejraye dobareye barname,etela'ate file ghabli az bein miravand!\n");
	unsigned int counter = 0;//shomareshgar baraye tarakonesh haye akhir
	FILE *fptr = fopen("atm.txt", "w+");
	FILE *f2ptr;
	f2ptr = fopen("tarakonesh.txt", "w+");//file baraye tarakonesh ha
	struct tarakonesh tr[90][20];//yek araye 2 bo'di ke 20 tarakonesh akhare 90 kart ra dar bar darad
	int c;
	for (c = 0; c<90; c++)//meghdar dahi avalie
	{
		eachCard[c].cardNo = 0; eachCard[c].pass = 0; eachCard[c].accounts = 0;
		fprintf(fptr, "%u%u%f", eachCard[c].cardNo, eachCard[c].pass, eachCard[c].accounts);
	}
	unsigned int i;//shomare khane haye araye eachCard[]
	struct atm eachCard[90];
	struct tarakonesh eachTarakonesh[20];

	unsigned int gozine;//meghdar az 1 ta 3 baraye menueye asli
	int flag = 1;
	while (flag)//halghe baraye namayeshe 3 menueye asli
	{
		printf("\nMotanaseb ba amaliate morede nazare khod, adade marboote ra vared namayid");
		printf("\ntarife karte jadid:1");
		printf("\nvoroode karte jadid:2");
		printf("\nkhatemeye ejraye barname:3\n");//3 menueye asli
		scanf("%u", &gozine);//entekhbe menue tavasote karbar az 1 ta 3

		if (gozine == 1)//tarife karte jadid
		{
			printf("\netela'ate zir ra be tartib vared konid:");
			printf("\nshomare kart(4 raghami),ramze kart(2 raghami),mojoodi,nam va namekhanevadegi\n");//gereftane etela'ate kart az karbar
			unsigned int newNo1;
			scanf("%u", &newNo1);//voroode shomare kart tavasote karbar baraye baraye tarife karte jadid
			i = newNo1 - 1000;//mikhahim kert ha ra be tartib dar araye bechinim(khane haye araye az 0 sohroo mishavand)
			eachCard[i].cardNo = newNo1;
			scanf("%u%lf", &eachCard[i].pass, &eachCard[i].accounts);//gareftane ramz va mojoodi karte jadid az karbar
			getchar();
			gets_s(eachCard[i].name);//gereftane nam va name khanevadegie sahebe kartejadid az karbar
			fprintf(fptr, "%u%u%s%lf", eachCard[i].cardNo, eachCard[i].pass, eachCard[i].name, eachCard[i].accounts);//ezafe kardane etela'at be file
			printf("Etela'ate karte shoma sabt shod.");
		}//end of if(gozine==1)

		if (gozine == 2)//voroode karte jadid
		{
			printf("\nShomare kart ra vared konid(4 raghami):\n");
			unsigned int newNo2;
			scanf("%u", &newNo2);//gereftane shomare kart az karbar
			i = newNo2 - 1000;//tayine khaneye makhsoos be in kart dar araye
			fscanf(fptr, "%u", &eachCard[i].cardNo);//gereftane shomare karte mojood dar an khane az araye (baraye inke bebinim ba shomare karti ke karbar vared karde yeksan ast ya na)
			if (eachCard[i].cardNo != newNo2)//moghayeseye shomare karte vared shode tavasote karbar ba shomare karte mojood dar khaneye marbooteye araye
			{
				printf("\nCart nabotabar ast!!!");//vaghti barabar nabashand
			}
			else//vaghti barabar bashand
			{
				int flam = 0;
				printf("\nRamz ra vared konid(2 raghami):\n");
				unsigned int newPass;
				unsigned int j;
				scanf("%u", &newPass);//gereftane ramze kart az karbar
				fscanf(fptr, "%u", &eachCard[i].pass);
				for (j = 1; j <= 3; j++)//barresiye 3 bar vared shodane ramze eshtebah
				{
					while (newPass != eachCard[i].pass)//ramze eshtebah
					{
						printf("\nRamz eshtebah ast!!!");
						if (j < 3)//vaghti hanooz ramz 3 bar eshtebah vared nashode
						{
							printf("\nRamz ra mozadadan vared konid:\n");
							scanf("%u", &newPass);
							break;
						}
						else//vaghti baraye bar 3om ramz eshtebah vared shod
						{
							printf("\nKarte shoma zabt shod.\n");
							flam = 1;
							break;
						}

					}
				}
				//vaghti ramz dorost vared shod
				int fll = 0;
				if (flam == 0)
				{
					int flaf = 1;
					while (flaf)//halghe baraye namayeshe menueye shesh gane
					{
						printf("\nAmaliate morede nazare khod ra ba type kardane shomareye marboot be an, entekhab konid:");
						printf("\nDaryafte mojoodi:1");
						printf("\nBardashte vajh:2");
						printf("\nVarize vajh:3");
						printf("\nTavize ramz:4");
						printf("\nVarize kart be kart:5");
						printf("\nMoshahedeye tarakonesh haye akhir:6");
						printf("\nHich kodam(Kharej shodan az menueye shesh gane):7\n");//menueye 6 gane
						int amaliat;
						scanf("%d", &amaliat);//Entekhab az menueye shesh gane

						if (amaliat == 1)//Mojoodi
						{
							fscanf(fptr, "%u%s%lf", &eachCard[i].cardNo, eachCard[i].name, &eachCard[i].accounts);//gereftane etela'ate kart az file
							printf("\nshomare kart=%u", eachCard[i].cardNo);
							printf("\nnam va name khanevadegi sahebe kart = %s", eachCard[i].name);
							printf("\nmojoodi = %f", eachCard[i].accounts);//neshan dadane etela'at be karbar
							flaf = 1;//neshan dadane dobareye menueye shesh gane
							flag = 0;
						}//if(amaliat==1)

						if (amaliat == 2)//Bardasht
						{
							printf("\nMablaghe bardashti ra vared konid:\n");
							double bardasht;
							for (;;)
							{
								scanf("%lf", &bardasht);//tayine meghdare bardasht tavasote karbar
								if (bardasht > 200000)//bardasht bish az hade mojaz
								{
									printf("\nMablaghe bardashti nabayad az 200 hezar tooman bishtar bashad!!!");
									printf("\nDobare mablagh ra vared konid:\n");
									continue;
								}
								if (bardasht > eachCard[i].accounts)//bardasht bish az mojoodi
								{
									printf("\nMablaghe bardashti az mojoodi hesabetan bishtar ast!!!");
									printf("\nDobare mablagh ra vared konid:\n");
									continue;
								}
								printf("\nAya az anjame amaliat motmaen hastid?");
								printf("\nDar soorate etminan 'Y' ra type konid:");
								printf("\nDar gheyre in sorat 'N' ra type konid:\n");
								char tayid1;
								getchar();
								tayid1 = getchar();//Y or N
								if (tayid1 == 'Y')//taeede karbar baraye bardasht
								{
									fscanf(fptr, "%lf", &eachCard[i].accounts);
									eachCard[i].accounts = eachCard[i].accounts - bardasht;//update mojoodi kart pas az bardasht
									fprintf(fptr, "%f", eachCard[i].accounts);
									printf("\nMablaghe bardashti=%f\nMojoodie jadid=%f", bardasht, eachCard[i].accounts);//neshan dadane etela'ate kart be karbar pas az update

										//voroode etela'ate tarakonesh be file
									eachCard[i].j = (eachCard[i].j) + 1;//shomare khoone tarakonesh ++
									(tr[i][eachCard[i].j]).mablagh = bardasht;
									(tr[i][eachCard[i].j]).typeOfTarakonesh = 1;
									printf("\ntarikh ra vared konid.be in form 'rooz/mah':\n");//voroode tarikh tavasote karbar
									getchar();
									gets_s((tr[i][eachCard[i].j]).date);
									fprintf(f2ptr, "%f,%d,%s", (tr[i][eachCard[i].j]).mablagh, 1, (tr[i][eachCard[i].j]).date);
										//(voroode etela'ate tarakonesh be file) ta in ja bood

								}
								if (tayid1 == 'N')//adame taeede karbar baraye bardasht
								{
									printf("\nAmaliat motabeghe darkhastetan laghv shod!!!");
								}
								break;
							}
							flaf = 1;//Neshan dadane dobareye menueye shesh gane
							flag = 0;
						}//if(amaliat==2)

						if (amaliat == 3)//Variz
						{
							printf("\nMablaghe varizi ra vared konid:\n");
							for (;;)
							{
								double variz;
								scanf("%lf", &variz);//tayine meghdare variz tavasote karbar
								if (variz > 3000000)//variz bish az hade mojaz
								{
									printf("\nMablaghe varizi nabayad az 3 milion tooman bishtar bashad!!!");
									printf("\nDobare mablagh ra vared konid:\n");
									continue;
								}
								printf("\nAya az anjame amaliat motmaen hastid?");
								printf("\nDar soorate etminan 'Y' ra type konid:");
								printf("\nDar gheyre in sorat 'N' ra type konid:\n");
								char tayid2;
								getchar();
								tayid2 = getchar();//Y or N
								if (tayid2 == 'Y')//tayide karbar baraye variz
								{
									fscanf(fptr, "lf", &eachCard[i].accounts);
									eachCard[i].accounts = eachCard[i].accounts + variz;//update mojoodi pas az variz
									fprintf(fptr, "f", eachCard[i].accounts);
									printf("\nMablaghe varizi=%f\nMojoodie jadid=%f", variz, eachCard[i].accounts);
									counter;//Tedade tarakonesh ha

										//voroode etela'ate tarakonesh be file
									eachCard[i].j = (eachCard[i].j) + 1;//shomare khoone tarakonesh ++
									(tr[i][eachCard[i].j]).mablagh = variz;
									(tr[i][eachCard[i].j]).typeOfTarakonesh = 2;
									puts("\ntarikh ra vared konid.be in form 'rooz/mah':");//voroode tarikh tavasote karbar
									getchar();
									gets_s((tr[i][eachCard[i].j]).date);
									fprintf(f2ptr, "%lf,%d,%s", tr[i][eachCard[i].j].mablagh, 2, (tr[i][eachCard[i].j]).date);
										//(voroode etela'at) ta inja bood

								}
								if (tayid2 == 'N')//adame tayide variz
								{
									printf("\nAmaliat motabeghe darkhastetan laghv shod!!!");

								}
								break;
							}
							flaf = 1;//neshan dadane dobareye menueye shesh gane
							flag = 0;
						}//if(amaliat==3)

						if (amaliat == 4)//tavize ramz
						{
							printf("\nRamze fe'li ra vared konid(2 raghami):\n");
							unsigned int currentPass;
							scanf("%u", &currentPass);//gereftane ramze fe'li az karbar
							fscanf(fptr, "%u", &eachCard[i].pass);
							if (eachCard[i].pass != currentPass)//moghyeseye ramze vared shode tavasote karbar ba ramze kart
							{
								printf("Ramz eshtebah ast!!!");
							}
							else//vaghti ramz dorost ast
							{
								for (;;)
								{
									unsigned int newPass1;//ramze jadid
									printf("\nRamze jadid ra vared konid(2 raghami):\n");
									scanf("%u", &newPass1);
									printf("\nRamze jadid ra mojadadan vared konid(2 raghami):\n");
									unsigned int newPass2;//mojadadan ramze jadid
									scanf("%u", &newPass2);
									if (newPass1 != newPass2)
									{
										printf("\nRamz haye vared shode ba ham motabeghat nadarand!!!");
										continue;
									}
									if (newPass1 == newPass2)
									{
										fscanf(fptr, "u", &eachCard[i].pass);
										eachCard[i].pass = newPass1;
										fprintf(fptr, "u", eachCard[i].pass);//sabte ramze jadid dar file
										printf("\nRamz ba movafaghiat taghir kard.");
										break;
									}
								}
							}
							flaf = 1;//neshan dadane dobareye menueye shesh gane
							flag = 0;
						}//if(amaliat==4)

						if (amaliat == 5)//enteghal
						{
							printf("\nShomare karte maghsad ra vared konid(4 raghami):\n");
							unsigned int newCardNo1;//shomare karte maghsad
							scanf("%u", &newCardNo1);
							int j;
							j = newCardNo1 - 1000;//tayine khaneye kart dar araye
							fscanf(fptr, "%u", &eachCard[j].cardNo);
							if (eachCard[j].cardNo != newCardNo1)//vaghti kart dar file vojood nadarad
							{
								printf("\nCarte maghsad nabotabar ast!!!");
								printf("\nAmaliat laghv shod!!!");
							}
							else//agar kart vojood dasht
							{
								printf("\nMablaghe morede nazar jahat enteghal ra vared konid:");
								for (;;)
								{
									double enteghal;
									scanf("%lf", &enteghal);//tayine mablaghe enteghali tavasote karbar
									if (enteghal > 5000000)//enteghal bish az hade mojaz
									{
										printf("\nMablaghe enteghali nabayad az 5 milion toman bishtar  bashad!!!");
										printf("\nDobare mablagh ra vared konid:\n");
										continue;
									}
									fscanf(fptr, "%u", &eachCard[i].accounts);
									if (enteghal > eachCard[i].accounts)//enteghal bish az mojoodie mabda'
									{
										printf("\nMablaghe enteghali az mojoodi bishtar ast!!!");
										printf("\nDobare mablagh ra vared konid:\n");
										continue;
									}
									fscanf(fptr, "%u%lf", &eachCard[j].cardNo, &enteghal);
									printf("\nNAme sahebe karte maghsad=%s\nMAblaghe enteghali=%f", eachCard[j].name, enteghal);
									printf("\nAya az anjame amaliat motmaen hastid?");
									printf("\nDar soorate etminan 'Y' ra type konid:");
									printf("\nDar gheyre in sorat 'N' ra type konid:\n");
									char tayid3;
									getchar();
									tayid3 = getchar();//Y or N
									if (tayid3 == 'Y')//tayide karbar baraye enteghal
									{
										fscanf(fptr, "%u", &eachCard[i].accounts);
										eachCard[i].accounts = eachCard[i].accounts - enteghal;//update mojoodi mabda'
										fprintf(fptr, "%u", eachCard[i].accounts);
										fscanf(fptr, "%u", &eachCard[j].accounts);
										eachCard[j].accounts = eachCard[j].accounts + enteghal;//update mojoodi maghsad
										fprintf(fptr, "%u", eachCard[j].accounts);
										printf("\nShomare karte mabda'=%u\nShomare karte maghsad=%u\nMablaghe enteghali=%f", eachCard[i].cardNo, eachCard[j].cardNo, enteghal);
									}
									if (tayid3 == 'N')//adame tayide karbar
									{
										printf("\nAmaliat motabeghe darkhastetan laghv shod!!!");
									}
									break;
								}
							}
							flaf = 1;//neshan dadane dobareye menueye shesh gane
							flag = 0;
						}//if(amaliat==5)

						if (amaliat == 6)//moshahedeye tarakonesh haye akhir
						{
							printf("\nTedade tarakonesh heyi ke ghasde moshahedeye anha ra darid,vared konid:");
							printf("\n(hade'aksar 20 ta)\n");
							int tedadTarakonesh;
							int tedad;
							scanf("%d", &tedadTarakonesh);//tedade tarakonesh haye akhir
							if (tedadTarakonesh > (eachCard[i].j)+1)
							{
								printf("Tarakonesh haye mojood az in tedad kamtar hastand!");
							}
							else
							{
								tedad = tedadTarakonesh - 1;
								for (tedad; tedad >= 0; tedad--)//az akhr print konad(chon mikhahim nozooli bashad)
								{

									printf("mablagh:%f  ,  type:%d  ,  tarikh:%s\n(type: 1=bardasht va 2=variz)", tr[i][tedad].mablagh, (tr[i][tedad]).typeOfTarakonesh, (tr[i][tedad]).date);

									printf("\n____________________________________________________________\n");
								}
							}
							flaf = 1;//neshan dadane dobareye menueye shesh gane
							flag = 0;
						}//if(amaliat==6)

						if (amaliat == 7)//khorooj az menueye shesh gane
						{
							fll = 1;
							flaf = 0;
							flag = 1;//bazgasht be 3 menueye asli
							break;//khorooj az menueye shesh gane
						}//if(amaliat==7)
						if (fll)break;
					}//end of while(flaf)
				}
			}
		}//end of if(gozine==2)
		if (gozine == 3)//khateme
		{
			return 0;
		}//end of if(gozine==3)
	}//end of while(flag)

	fclose(fptr);
	fclose(f2ptr);
	return 0;
}//end of main