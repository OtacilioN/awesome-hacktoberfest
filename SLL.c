// INSERTION AFETR A GIVEN POSITION

#include<stdio.h>
#include<malloc.h>
struct node
	{
		int data;
		struct node *link;
	};
		
		
		
struct node *start=NULL;
struct node *ptr,*temp;
struct node *prev;


void create();
void insert();
void display();
void delete_from_beg();
void insert_at_beg();
void delete_from_end();
void delete_at_pos();
void length();
void reverse();

int main()
{
	
	int choice;

/////////////////////////////////////////////////////////////	
	while(1)
	{
	printf("What do you want?\n1: Insert at End\n2: Insert at begining\n3: Insert after a given position\n4: Delete from begining\n5: delete from end\n6: Delete at a particular position\n7: Count the length\n8: Reverse the link list\n9: Display\n");
	scanf("%d",&choice);
	
	if(choice==1)
	{
		create();
	}
	else if(choice==2)
	{
		insert_at_beg();
		
	}
	else if(choice==3)
	{
		insert();
	}
	else if(choice==4)
	{
		delete_from_beg();
	}
	else if(choice==5)
	{
		delete_from_end();
	}
	else if(choice==6)
	{
		delete_at_pos();
	}
	else if(choice==7)
	{
		length();
	}
	else if(choice==8)
	{
		reverse();
	}
	else if(choice==9)
	{
		display();
	}
	else
	{
		break;
	}
}	
}
/////////////////////////////////////////////////////////////////////
void insert()
{

	int item,i=1,pos;
	temp = (struct node *)malloc(sizeof(struct node));
	printf("Enter data: ");
	scanf("%d",&item);
	
	
	temp->data=item;
	temp->link=NULL;
	printf("Enter the position after which you want to insert you node: ");
	scanf("%d",&pos);
	ptr=start;
	while(i<pos)
	{
		ptr=ptr->link;
	}
		
		temp->link = ptr->link;
		ptr->link=temp;	
}

void reverse()
{
	struct node *next;
	prev=NULL;
	
	ptr=next=start;
	while(next!=NULL)
	{
		next=next->link;
		ptr->link=prev;
		prev=ptr;
		ptr=next;
	}
	
	start=prev;
	
}

void length()
{
	int count=0;
	ptr=start;
	
	while(ptr!=NULL)
	{
		count=count+1;
		ptr=ptr->link;
	}
	printf("Length of Linked List is: %d\n",count);
}
void insert_at_beg()
{
	int item,i=1,pos;
	temp = (struct node *)malloc(sizeof(struct node));
	printf("Enter data: ");
	scanf("%d",&item);
	
	
	temp->data=item;
	temp->link=NULL;
	if(start==NULL)
	{
		start=temp;
	}
	else
	{
		temp->link = start;
		start=temp;
	}
}

void delete_at_pos()
{
	int pos,i=1;
	//struct node *prev;
	printf("Enter the position where you want to delete: ");
	scanf("%d",&pos);
	ptr=start;
	while(i<pos)
	{
		prev=ptr;
		ptr=ptr->link;
		i++;
	}
	
	prev->link = ptr->link;
	ptr->link=NULL;
	free(ptr);
	
	
}

void create()

{
	int item;
	
	

	temp = (struct node *)malloc(sizeof(struct node));
	printf("Enter data: ");
	scanf("%d",&item);
	
	
	temp->data=item;
	temp->link=NULL;
	//printf("Enter the position after which you want to insert you node: ");
	//scanf("%d",&pos)
	if(start==NULL)
	{
		start=temp;
	}
	else
	{
		ptr=start;
	
	while(ptr->link!=NULL)
	{
		ptr=ptr->link;
	}
	ptr->link =temp;
	
}
}

void delete_from_beg()
{
	if(start==NULL)
	{
		printf("Underflow Condition/n");
	}
	else
	{
		ptr=start;
		start=ptr->link;
		free(ptr);
	}
}

void delete_from_end()
{
	struct node *prev;
	if(start==NULL)
	{
		printf(" THERE IS NOTHING TO DELETE GET LOST!!!!");
	}
	else
	{
		ptr=start;
		while(ptr->link!=NULL)
		{
			prev=ptr;
			ptr=ptr->link;
		}
		
		prev->link=NULL;
		
		free(ptr);
	}
}

void display()
{
	if(start==NULL)
	{
		printf("EMpty\n\n");
	}
	
	else
	{
	
	ptr=start;
	while(ptr!=NULL)
	{
		printf("%d\n",ptr->data);
		ptr=ptr->link;
	}
	
}
}
	
	
	
	

	

