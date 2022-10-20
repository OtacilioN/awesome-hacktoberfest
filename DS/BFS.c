//imeplement BFS
// 1 for ready (wait for q), 2 for running (inside q) 3 for execute (print)
#include<stdio.h>
#define MAX 10
int front,rear;
void insert(char s[], char k)
{
    if(rear==MAX-1)
     printf("\n overflow");
    else
    {
        if(rear==-1)
        {
            front=0;
            rear=0;
            s[rear]=k;
        }
        else
        s[++rear]=k;
    }
}

char Delete(char s[])
{
    char t=s[front];
    if(front==rear)
    {
        front=-1;
        rear=-1;
    }
    else
     front++;
    return t;
}
void main()
{
    char queue[MAX],item;
    int a[MAX][MAX];
    int n,i,j,p,e;
    int s[MAX];
    front=-1,rear=-1;
    
    printf("Enter no. of vertex ");
    scanf("%d",&n);
    printf("\n enter value \n");
    for(i=0;i<n;i++)
    {
        for(j=0;j<n;j++)
        {
            scanf("%d",&a[i][j]);
        }
    }
    for(i=0;i<MAX;i++)
     s[i]=1; // assign ready state for each node
     
    printf("A");
    s[0]=3; // execute [initialize]
    e=1;//AS first node already execute
    p=0;// as execute first node
    while(e<n)
    {
        for(j=0;j<MAX;j++)
        {
            if(a[p][j]==1 && s[j]==1)    //a[p][j]=1 neighbour
            {
              insert(queue,(char)(j+65));
              s[j]=2;// update to running 
            }
        }
        item=Delete(queue);
        p=(int)item-65; 
        s[p]=3; //update to execute
        printf(" %c",item);
        e++; // execute one element
    }
    
    
}