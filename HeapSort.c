#include<stdio.h>
#include<conio.h>
void swap(int *x,int *y)
{
	int temp;
	temp=*x;
	*x=*y;
	*y=temp;
}
void heapify(int arr[],int n,int i)
{   //initial largest as root
	int largest=i;
	int l=(2*i)+1;//left
	int r=(2*i)+2;//right
	//left child is greater han right child
	if(l<n &&arr[l] >arr[largest])
		largest=l;
	//right child is greater han left child
	if(r<n &&arr[r] >arr[largest])   
    	largest=r;   
    if(largest!=i)   //if largest is not root   
    {
    	swap(& arr[i],& arr[largest]);
    	//recursively heapify the affected subtree
        heapify(arr,n,largest);  	
	}
}
void heapsort(int arr[],int n)
{
	int i;
	//build heap(rearrange array)
	for(i=(n/2)-1;i>=0;i--)
		heapify(arr,n,i);
	for(i=n-1;i>0;i--)  //one by one extract element from heap
	{
		swap(&arr[0],&arr[i]); //move curr to end
		heapify(arr,i,0);      //calling max heapify on reduced heapify
		}	
}
int main()
{
	int arr[10],i,n;
	printf("Enter number of elements to be sorted:\t");
	scanf("%d",&n);
	printf("Enter the element\n");
	for(i=0;i<n;i++)
		scanf("%d",&arr[i]);
	heapsort(arr,n);
	printf("Sorted Array ");
	for(i=0;i<n;i++)
		printf("%d ",arr[i]);	
}
