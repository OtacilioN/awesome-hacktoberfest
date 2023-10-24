#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#include<process.h>
#define MAX 20
char expo[MAX];
int top=-1;
void push( char item)
{
	if(top== MAX-1)
	{
		printf(" \n STACK FULL");
		return;
	}
	else
	{
		top = top+1;
		expo[top]= item;
	}
}
char pop()
{
	char ret;
	if(top == -1)
	{
		printf(" \n STACK EMPTY");
		return -111;
	}
	else
	{
		ret = expo[top];
		top= top-1;
		return ret;
	}
}
int match(char a, char b)
{
	if(a== '[' && b== ']')
	    return 1;
	if(a== '{' && b== '}')
	   return 1;
	if(a== '(' && b== ')')
	    return 1;
	return 0;
}
int isbalanced(char expo[])
{
	int i;
	char temp;
	for(i=0; i<strlen(expo); i++)
	{
		if(expo[i] == '(' || expo[i] == '{' || expo[i] == '[')
		   push(expo[i]);
		if(expo[i] == ')' || expo[i] == '}' || expo[i] == ']')
		{
			if(top==-1)
			{
				printf("\n Right parantheses are more than left parantheses");
				return 0;
			}
			else
			{
				temp = pop();
				if(!match(temp,expo[i]))
				{
					printf(" \n Mismatched parantheses are :");
					printf(" %c & %c \n" , temp, expo[i]);
					return 0;
				}
			}
		if(top==-1)
		{
			printf("Balanced Parantheses \n");
			
			return 1;
		}
		else 
		{
		   printf("Left parantheses more than right parantheses");
		   return 0;	
		}  
	  }
}
}
int main()
{
	char expo[MAX];
	int valid;
	printf("Enter an algebraic expression : ");
	gets(expo);
	valid= isbalanced(expo);
	if(valid==1)
	   printf("valid expression \n");
	else
	   printf("invalid expression\n");
}
