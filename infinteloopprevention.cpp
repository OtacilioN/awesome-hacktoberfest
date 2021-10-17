#include<bits/stdc++.h>
using namespace std;
int main()
{
	int loops=0;	//extra variable to detect total loops
	int n;
	cout<<"Enter value of n:";
	cin>>n;
	for(int i=0;i<n;i++)
	{
		n+=5;
		//below block is extra code for checking infinite loops
		if(loops++>100000000)	//incrementing the variable while checking
		{
			cout<<"loop1 leads infinite loop :)";
			return 0;	
		}
	}
	while(1)
	{
		n*=5;
		n/=1;
		
		//below block is extra code for checking infinite loops
		if(loops++>100000000)	//incrementing the variable while checking
		{
			cout<<"loop2 leads infinite loop :)";
			return 0;
		}
	}
}
