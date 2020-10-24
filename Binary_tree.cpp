/*Write a program to create a binary tree. Your program should able to create a binary tree for an arbitrary number of elements
given and print the element at each node in the binary tree. The program should contain at least the following functions:
1. binaryCreate ( ) will create a binary tree with single node.
2. binaryInsert ( ) will insert a node to the existing binary tree.
3. binaryPrint ( ) will print the value of a node in the tree.
4. binaryPrintchild ( ) will print the child (right and left child) of a node if exist, else return 0.
Appropriate parameter must be passed to the above functions. Each node has unique identifier, which is used to identify the node. 
To the function, binaryPrint (), and binaryPrintchild (), the identity of the node is passed as one of the parameter.
To test your program, create a binary tree with few elements (for example B, D, R , T , E , M, N, P). Print the element at specific nodes, and its left and right child. 
For the elements, mentioned above the left child of D will be T and the right child will be E.
*/
# include <iostream>
using namespace std;
struct node                                                     //structure
{ 
    char val;                                                   //to store value at nodes
    struct node * next;
};
struct node * binaryCreate ( char data )                        //create a node
{
    struct node * temp = new node;
    temp->val = data;
    temp->next = NULL;
    return temp;
}
struct node * binaryInsert ( struct node * head, char data )    // Insertion of element
{
    struct node *temp = binaryCreate ( data );               // storing data in node
    struct node * ptr = head;
    if(ptr==NULL)
    head=temp;
    else
    {
        while(ptr->next!=NULL)
            ptr=ptr->next;
        ptr->next = temp;
    }
    return head;

}
void binaryPrint( struct node * head , int id )            //Print node data
{
    int vid = id-1;
    while(vid-- && head!= NULL)
    {
        head =head->next;
    }
    cout<<"Value at node : "<<head->val<<"\n";
}
void binaryPrintchild( struct node * head, int id )     //Print left and right child
{
    int lc=2*id-1;
    while(lc-- && head!= NULL)
    {
        head =head->next;
    }0
     {
        cout<<"Enter a input\n";
        cin>>data;
        head=binaryInsert(head,data);                               // call insert function to insert nodes.
        cout<<"Enter 1 to enter more elements else 0 to exit\n";
        cin>>ch;  
    } while (ch != 0);
    cout<<"Enter identifier of node ( a number between 1 to n)\n";
    cin>>id;
    binaryPrint(head,id); 
    binaryPrintchild(head,id);                                     // call print function
    return 0;
}