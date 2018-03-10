//-----------------------------------------------------------------------------
//Name: Html Scheduler
//Author: Matt Donahoe
//School: Mendham
//Computer Used: Dell Inspiron 8100
//Programming Language Used: C++
//Date: 4-6-03
//Purpose: To easily create an html calendar of events without coding HTML
//-----------------------------------------------------------------------------
#include <fstream>
#include <iostream>
#include <stdlib.h>
#include <math.h>
using namespace std;

void start();//Starting function: asks for the current date
// and then loads all events that are beyond the current date.

void output();//Outputs the information as html files and creates the calendar.

char load();//loads a .txt file

char choice(string);//Asks for user input on a choice and does not exit until
//the input is correct. Letters of the passed string are acceptable responses

char kill();//Removes an event from the programs list.

char pick();//Allows the user to choose an event from a list of events

char menu();//this is the main menu that lets the user decide what to do

char edit();//All editing of events, whether new or old, is done here

char find();//Locates an event based on a user inputted date

char order();//Sorts the array of event dates

char display();//displays event information and prompts the user with a choice

char save();//saves event information to a .txt file

char caps(char);//converts lowercase to uppercase

string dateme();//asks the user to input a date

string time(string);//converts the time from 24 hour to 12 hour

string str(int);//converts a number<100 to a 2 digit string

int whatday(string);//uses the date inputted as a string to find the weekday

int datemax(int,string); // outputs the maximum values for a date

int val(string);//converts a numerical string to an integer

bool fresh=true;//tells edit() whether the event is being created or updated

string current;//the current date

string file;//the date of the current event

const int DATES_ARRAY_MAX=200;
string dates[DATES_ARRAY_MAX];//list of all availible events

const int INFO_ARRAY_MAX=50;
string info[INFO_ARRAY_MAX];//list of all the text in the current event

string instr[5]={"year. Enter 2003 as 3\n",
                "month. Enter January as 1\n",
                "day. Enter the 21st as 21\n",
                "hour. Enter 8pm as 20\n",
                "minute. Enter :32 as 32\n"};
//list of instructions for date inputting...makes function more efficient

string monthname[12]={"January","February","March","April","May","June",
                    "July","August","September","October","November","December"};
//the names of the months...duh

string weekday[7]={"Sunday","Monday","Tuesday","Wednesday",
                    "Thursday","Friday","Saturday"};
//the names of the weekdays...duh

int datemin[5]={3,1,1,0,0}; //the minimum values for a date

int filenum;  //the number where the current file will be places in dates[]

int datamax; //the end of dates[]

int user=0;   //experienced or unexperience user...changes how dates are inputted

ifstream fin;  //input file stream

ofstream fout;  //output file stream
//---------------------------------------------------------------------------
int main()
{
    char a='M';  //variable that determines what function is run next
    bool loop=true; //loop control
    
    cout << "Html Scheduler\nby matt donahoe\n";
    start();
    while(loop)
    {
        switch(a)
        {
        	case ('M'):
        		a=menu();
        		break;
        	case ('E'):
        		a=edit();
        		break;
       		case ('F'):
       			a=find();
       			break;
            case ('D'):
                a=display();
                break;
            case ('L'):
                a=load();
                break;
            case ('K'):
                a=kill();
                break;
            case ('O'):
               a=order();
            	break;
            case ('P'):
                a=pick();
            	break;
         	case ('S'):
                a=save();
             	break;
            case ('Q'):
            	loop=false;
          		break;
            default:
            	cout << "\nError!";
            	a='M';
            	break;
        }
    }
    output();
    cout <<"\nBefore you leave me...what is your name?";
    cin >> a;
    return 0;
}

//The Important Functions
void start()
{
    string datum; //variable for info pulled from a file
    int i; //increment variable
    
    fin.open("./data/data.txt");
    getline(fin, datum);
    user=val(datum);
    if (user==1){cout << "\nHello advanced user...";}
    cout << "\nIn order to update properly, the current date is required";
    current=dateme();
    getline(fin, datum);
    i=0;
	while (!fin.eof()&&(i<(DATES_ARRAY_MAX-2)))
	{
        if (datum>=current){dates[i++]=datum;}
        getline(fin, datum);
	}
	if (datum>=current){dates[i++]=datum;}
	datamax=i;
	cout << i << " events found\n";
    fin.clear();
    fin.close();
}

char menu()
{
    fresh=true;
    filenum=-1;
    string opts="";
    char z; //user choice variable
    
    cout << "\nMain Menu:\n\nPress the letter of your selection and hit ENTER";
    if (datamax<DATES_ARRAY_MAX){cout <<"\n\n(N)-- New event"; opts="N";}
    cout << "\n(F)-- Find event\n(P)-- Pick event\n(Q)-- Quit out\n";
    opts+="FPQ";
    z=choice(opts);
    if (z=='N'){filenum=datamax++;z='E';}
    return z;
}

char find()
{
    char z; //user choice variable
    int i;//increment variable
    
    cout << "To find the event, ";
	file=dateme();
	filenum=-1;
    for (i=0;i<datamax;i++)
	{
        if (file==dates[i]){filenum=i;}
    }
    if (filenum==-1)
    {
        cout << "\nFile not found!\nWould you like to try again? (Y or N)\n";
        z=choice("YN");
        if (z=='Y'){return 'F';}else{return 'M';}
    }
    return 'L';
}
char pick()
{
    string options="ABCDEFGHIJ";//available options
    string opts;//the currently used options
    string temp;//temporary file name
    string openfile;//file directory and stuff
    string name;//where the name of the event goes
    int i=0;//increment by 10, i+j is the current spot in the array dates[]
    int j;//increment variable
    char z;//user choice variable
    bool loop=true;//loop variable...duh
    cout << '\n' << datamax << " events total";
    while(loop)
    {
        opts="";
        cout << "\nMake a selection:";
        for(j=0;j<10;j++)//display up to 10 events at a time
        {
            if ((j+i)<datamax)
            {
            temp=dates[j+i];
            openfile="./data/"+temp+".txt";
            fin.open(openfile.c_str());
            getline(fin,name);
            cout << "\n(" << options[j] << ")-- " << name << ": "
             << weekday[whatday(temp)].substr(0,3)
             << ", " << monthname[val(temp.substr(2,2))-1].substr(0,3) << " "
             << val(temp.substr(4,2)) << ", 20" << temp.substr(0,2)
             << " " << time(temp);
            opts+=options[j];
            fin.clear();
            fin.close();
            }
        }
        cout << '\n';
        if ((j+i)<datamax)
        {
            cout << "\n(N)-- Next events";
            opts+="N";
        }
        cout << "\n(M)-- goto the Menu\n";
        opts+="M";
        z=choice(opts);
        for (j=0;j<10;j++)
        {
            if (z==options[j])
            {
                loop=false;
                file=dates[i+j];
                filenum=i+j;
            }
        }
        if (z=='N'){i+=10;}
        if (z=='M'){loop=false;}
    }
    if (z=='M'){return z;}
    return 'L';
}

char load()
{
    string openfile;//file directory and stuff
    string datum;//current info pulled from file
    int i=0;
    openfile="./data/"+file+".txt";
	fin.open(openfile.c_str());
	getline(fin, datum);
	while (!fin.eof())
	{
		info[i++]=datum;
		getline(fin, datum);
	}
	info[i++]=datum;
	info[i]="end";
	fin.clear();
	fin.close();
	return 'D';
}    

char edit()
{
    int i;//increment variable
	string temp;
    bool y=fresh;
	char z;//user choice variable
 	int a=0;
  	
    if (!fresh)
   	{
    	cout << "Would you like to change the starting date of the event?"
            << " (Y or N)\n";
    	z=choice("YN");
		if (z=='Y'){y=true;}
	}
	z=' ';
    if (y){file=dateme();}
 	y=fresh;
  	if (!fresh)
   	{
    	cout << "Would you like to change the name of the event? (Y or N)\n";
    	z=choice("YN");
		if (z=='Y'){y=true;}
	}
	if (y)
	{
		info[0]="";
  		cout << "Enter the name of the event\n?:";
        cin >> ws;
		getline(cin, info[0]);
	}
        i=1;
	z=' ';
    if (!fresh)
 	{
	 	while(info[i]!="end")
        {
            cout << '\n' << info[i] << "\nWould you like to edit this description?"
                << " (Y or N)\n";
            z=choice("YN");
            if (z=='Y')
			{
				cout << "\ndescription " << i << "\n?:";
                cin >> ws;
				getline(cin, info[i]);
			}
			i++;
		}
	}
	z=' ';
    while ((z!='N')&&(i<(INFO_ARRAY_MAX-2)))
	{
	 	z=' ';
        cout << "\nWould you like to add description? (Y or N)\n";
		z=choice("YN");
		if (z=='Y')
		{
			cout << "\ndescription " << i << "\n?:";
            cin >> ws;
			getline(cin, info[i++]);
		}
  	}
	info[i]="end";
    fresh=false;
	return 'D';
}

char display()
{
	char z; //user choice variable
    int i=0;//increment variable
 	
    cout << "\nName: " << info[0] << "\nDate: " << weekday[whatday(file)]
        << ", " << monthname[val(file.substr(2,2))-1].substr(0,3) << " "
        << val(file.substr(4,2)) << ", 20" << file.substr(0,2)
 		<< "\nTime: " << time(file)<<"\nDescription:";
	while(info[++i]!="end"){cout << '\n' << info[i];}
	cout << "\n\nWould you like to:\n(E)-- Edit the file\n(S)-- Save the file\n"
        << "(K)-- Kill the file\n(M)-- goto the Menu\n";
    z=choice("ESKM");
	if (z=='E'){fresh=false;}
    return z;
}

char save()
{
	string openfile="./data/"+file+".txt";
    int i=0;//increment variable
	
    fout.open(openfile.c_str());
	fout << info[i];
    while(info[++i]!="end"){fout << '\n' << info[i];}
	fout.clear();
    fout.close();
	return 'O';
}
char order()
{
	string temp;//holdin space during date swap
    int i;//increment variable
    bool loop=true;//loop control
 	
    dates[filenum]=file;
    while (loop)
 	{
 	  	loop=false;
     		for(i=0;i<datamax-1;i++)
		{
			if(dates[i]>dates[i+1])
   			{
  				loop=true;
      			temp=dates[i];
     			dates[i]=dates[i+1];
        		dates[i+1]=temp;
          	}
		}
  	}
   	return 'M';
}

char kill()
{
    char z;//user choice variable
    
    cout << "\nAre you sure you want to delete this event? (Y or N)\n";
    z=choice("YN");
    if (z=='N'){return 'D';}
    file="9999999999";
    z=order();
    datamax--;
    return 'M';
}

void output()
{
    //initialization...
    int year=2000+val(current.substr(0,2));
    int month=val(current.substr(2,2));
    int startday=val(current.substr(4,2));
    int week=0;
    int day=1;
    int i=0;//increment variable
    int l;//increment variable
    char z;
    
    //updating data.txt
    string openfile;
    string name;
    string thedate;
    cout << "Wait.";
    fout.open("./data/data.txt");
    fout << str(user);
    for (i=0;i<datamax;i++){fout << '\n' << dates[i];}
    fout.clear();
    fout.close();
    
    //creating the calender
    fout.open("./html/calendar.html");
    fout << "<HTML>\n<HEAD><Title>Calendar</Title></HEAD>\n<BODY><center><h1>"
        << "The Next 6 Months</h1><br><br>";
    i=0;
    while(i<6)
    {
        day=1;
        thedate=str(year-2000)+str(month)+str(day);
        fout << "<h3>" << monthname[month-1] << " 20" << str(year-2000) << "</h3>"
            << "\n<TABLE BORDER CELLSPACING=1 CELLPADDING=7 WIDTH=750>\n"
            << "<TR><TD WIDTH=\"1%\" VALIGN=\"TOP\"></TD>\n"
            << "<TD WIDTH=\"14%\" VALIGN=\"TOP\">Sunday</TD>\n"
            << "<TD WIDTH=\"14%\" VALIGN=\"TOP\">Monday</TD>\n"
            << "<TD WIDTH=\"14%\" VALIGN=\"TOP\">Tuesday</TD>\n"
            << "<TD WIDTH=\"14%\" VALIGN=\"TOP\">Wednesday</TD>\n"
            << "<TD WIDTH=\"14%\" VALIGN=\"TOP\">Thursday</TD>\n"
            << "<TD WIDTH=\"14%\" VALIGN=\"TOP\">Friday</TD>\n"
            << "<TD WIDTH=\"14%\" VALIGN=\"TOP\">Saturday</TD>\n</TR>";
        while(day<=datemax(3,thedate))
        {
            fout << "\n<TR>\n<TD WIDTH=\"1%\" VALIGN=\"TOP\"><br><br><br><br></TD>";
            while((week<7))
            {
                if (day<=datemax(3,thedate))
                {
                    thedate=str(year-2000)+str(month)+str(day);
                }
                if (week==whatday(thedate))
                {
                    fout << "\n<TD WIDTH=\"14%\" VALIGN=\"TOP\">"
                        << day << "<br>";
                    for(l=0;l<datamax;l++)
                    {
                        if (thedate==dates[l].substr(0,6))
                        {
                            openfile="./data/"+dates[l]+".txt";
                            fin.open(openfile.c_str());
                            getline(fin, name);
                            fin.clear();
                            fin.close();
                            fout << "<small><a href=\"" << dates[l]
                                << ".html\">" << name
                                << "</a><br></small>";
                         }
                    }
                    fout << "</TD>";
                    day++;
                }
                else{fout << "\n<TD WIDTH=\"14%\"VALIGN=\"TOP\"></TD>";}
                week++;
            }
            fout << "\n</TR>";
            week=0;
        }
        fout << "\n</TABLE><br><br>";
        i++;
        month++;
        if (month>12)
        {
            month=1;
            year++;
        }
    }
    fout << "\n</body></html>";
    fout.clear();
    fout.close();
    
    //creating event html files
    for(l=0;l<datamax;l++)
    {
        file=dates[l];
        z=load();
        openfile="./html/"+file+".html";
        fout.open(openfile.c_str());
        fout << "<html>\n<head><title>"<< info[0]
            << "</title></head>\n<body><center><h1>" << info[0]
            << "</h1></center><br>" << "Date: " << weekday[whatday(file)]
            << ", " << monthname[val(file.substr(2,2))-1].substr(0,3)
            << " " << val(file.substr(4,2)) << ", 20" << file.substr(0,2)
            << "\n<br>Time: " << time(file)
            <<"\n<br>Description:";
        i=0;
        while(info[++i]!="end"){fout << "\n<br>" << info[i];}
        fout << "\n</body>\n</html>";
        fout.clear();
        fout.close();
    }
}

//User Interaction Functions with Input Error Handling Capabilities 
string dateme()
{
    int i;//increment variable
    string filer=""; //this is the filename/date
    string temp=""; //temporary sections of filer
    string z;//input variable. it is a string so the computer doesnt mess up
    //when it has a letter inputted as an integer
    int a;//integer for date comparison
    
    if (user==1)
    {
        cout << "\nEnter the date:";
        getline(cin, z);
        filer=z.substr(0,10);
    }else{
        for(i=0;i<5;i++)
		{
			a=-1;
            temp=filer;
            cout << "\nEnter the " << instr[i];
            while (temp<current.substr(0,(i+1)*2))
            {
                temp=filer;
                a=-1;
                while((a<datemin[i])||(a>datemax(i+1,filer)))
                {
                    cout << "?:";
                    getline(cin, z);
                    a=val(z);
                    if ((a<datemin[i])||(a>datemax(i+1,filer)))
                    {cout << "OUT OF POSSIBLE DATE RANGE!\n";}
                }
                temp+=str(a);
                if (temp<current.substr(0,(i+1)*2))
                {cout << "YOU CAN'T CHANGE THE PAST!\n";}
            }
            if (temp.length()<((i+1)*2))
            {
                while((a<datemin[i])||(a>datemax(i+1,filer)))
                {
                    cout << "?:";
                    getline(cin, z);
                    a=val(z);
                    if ((a<datemin[i])||(a>datemax(i+1,filer)))
                    {cout << "OUT OF POSSIBLE DATE RANGE!\n";}
                }
            }
            filer+=str(a);
		}
    }
    return filer;
}

char choice(string options)
{
    string z="";//user choice variable
    int i;//increment variable
    bool loop=true;
    while (loop)
    {
        cout << "?:";
    	getline(cin, z);
    	z[0]=caps(z[0]);
    	for (i=0;i<options.length();i++)
        {
            if (z[0]==options[i]){loop=false;}
        }
        if (loop){cout << "NOT AN OPTION!\n";}
    }
    return z[0];
}

//Computation Functions

int datemax(int toyp,string x)
{
    //toyp specifies whether a year month day hour or minute max is to be return
    int y=0; //value to be returned
    
    if (toyp==1){y=98;}
    if (toyp==2){y=12;}
    if (toyp==3)
    {
        int year=val(x.substr(0,2));
        int month=val(x.substr(2,2));
        switch (month)
        {
            case (1):
               y=31;
                break;
            case (2):
               if ((year%4)==0){y=1;}//if a leap year, add a day
               y+=28;
               break;
            case (3):
                y=31;
                break;
            case (4):
                y=30;
                break;
            case (5):
                y=31;
                break;
            case (6):
                y=30;
                break;
            case (7):
                y=31;
                break;
            case (8):
                y=31;
                break;
            case (9):
                y=30;
                break;
            case (10):
                y=31;
                break;
            case (11):
                y=30;
                break;
            case (12):
                y=31;
                break;
        }
    }
    if (toyp==4){y=23;}
    if (toyp==5){y=59;}
    return y;
}
string str(int x)
{
    float z=x;
    string y;
    if (z<10)
    {
        y=48;
        y+=48+z;
    } else
    {
        y=48+floor(z/10);
        y+=48+z-10*floor(z/10);
    }
    return y;
}
char caps(char x)
{
    if((x>96)&&(x<123))
    {x-=32;}else if((x<65)||(x>122)){x='X';}
    return x;
}
int val(string x)
{
	char y; //section of input string
	int temp=0; //temp number
 	int a=0; //final number
 	int i;//increment variable
 	int j;//increment variable

  	for(i=0;i<x.length();i++)
	{
		y=x[i];
		switch(y)
		{
			case ('0'):
				temp=0;
   				break;
			case ('1'):
				temp=1;
				break;
			case ('2'):
				temp=2;
				break;
			case ('3'):
				temp=3;
   				break;
			case ('4'):
				temp=4;
	   			break;
			case ('5'):
				temp=5;
   				break;
			case ('6'):
				temp=6;
				break;
			case ('7'):
				temp=7;
				break;
			case ('8'):
				temp=8;
				break;
			case ('9'):
				temp=9;
				break;
			default:
				temp=-9999; //if the input is not a number, flag it
                break;
		}
		for(j=0;j<(x.length()-i-1);j++)
		{
			temp*=10;
		}
 		a+=temp;
	}
	return a;
}
string time(string thisdate)
{
    string x=thisdate.substr(6,2);
    string y=thisdate.substr(8,2);
    string thetime;
    int hours=val(x);
    thetime="am";
    if (hours>11){thetime="pm";}
    if (hours>12){hours-=12;}
    thetime=str(hours)+':'+y+' '+thetime;
    return thetime;
}

int whatday(string x)
{
    //this programs increments the starting year month and day until they reach
    //the destination (dyear dmonth and dday)
    string date;
    int year=2;
    int month=12;
    int day=1;
    int type=0;
    int dyear=val(x.substr(0,2));
    int dmonth=val(x.substr(2,2));
    int dday=val(x.substr(4,2));
    while ((year<dyear)||(month<dmonth)||(day<dday))
    {
        day++;
        date=str(year)+str(month)+str(day);
        if (day>datemax(3,date))
        {
            day=1;
            month++;
        }
        if (month>12)
        {
        month=1;
        year++;
        }
        type++;
        if (type>6){type=0;}
    }
    return type;
}



