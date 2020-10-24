/*
Write a program to create a binary search tree. Your program should able to create a binary search tree and perform the operation such as inserting an element into the tree,
deleting an element from the tree, finding the smallest element from the tree, finding the largest element from the tree, and computing the total number of nodes in the binary search tree.
The program should contain at least the following functions:
1. createBinarySearchTree ( ) // This function will create an empty binary search tree.
2. insertBinarySearchTree ( ) // This function will insert an element into the binary search tree.
3. deleteBinarySearchTree ( ) // This function will delete an element from the binary search tree if exists else return “item to be deleted does not exists in the tree”.
4. findSmallestElement() // This function will return the smallest element in the binary search tree.
5. findLargestElement() // This function will return the largest element in the binary search tree.
6. totalElement() // This function will return the total number of elements in the binary search tree.
You need to find out the parameters that must be passed to the above functions, and the return type of each function to carry out the intended function.
Test your program before uploading.
*/
#include<iostream>
using namespace std;

//structure to create a tree containing a data value and left and right child.
struct tree
{
    int data;
    struct tree * left;
    struct tree * right;
};

// A function to create an empty binary search tree.
struct tree * createBinarySearchTree ()
{
    struct tree * new_tree = new tree;
    new_tree->left = NULL;
    new_tree->right = NULL;
    return new_tree;
}

// function to insert elements in binary search tree.
struct tree * insertBinarySearchTree(struct tree * root, int val)
{
    //create an empty ele tree and assign value to it.
    struct tree * ele = createBinarySearchTree();
    ele->data =  val;
    
    //store the ele tree in root , if the root of the tree itself is NULL.
    if(root==NULL)
        root= ele;
    
    struct tree * ptr = root;                   // A dummy variable ptr to traverse the tree.
    struct tree * prev;                         // A structure pointer prev to point to previous node  where data value is to be inserted.
    
    // A loop to obtain the position where data is to be inserted
    while(ptr != NULL && ptr->data != val)
    {
        if(val < ptr->data)
        {
            prev=ptr;
            ptr=ptr->left;
        }
        else if(val > ptr->data)
        {
            prev=ptr;
            ptr=ptr->right;
        }
    }
    
    // Checking this condition so that same element is not added again and assigning new tree to the found location.
    if(ptr == NULL)
    {
        if(val < prev->data)
            prev->left = ele;
        else
            prev->right = ele;
    }
    return root;
}

// function to return inorder successor
struct tree * minimumtree(struct tree* node) 
{ 
    struct tree* current = node; 
  
    //loop to find the leftmost child
    while (current && current->left != NULL) 
        current = current->left; 
  
    return current; 
}

// function to delete elements from binary search tree.
struct tree * deleteBinarySearchTree(struct tree * root, int val)
{
    if (root == NULL) 
    {
        cout<<"Item to be deleted doesnot exist.\n";
        return root;
    } 
  
    // If the key to be deleted is smaller than the root's key, then it lies in left subtree.
    if (val < root->data) 
        root->left = deleteBinarySearchTree(root->left, val); 
  
    // If the key to be deleted is greater than the root's key,  then it lies in right subtree
    else if (val > root->data) 
        root->right = deleteBinarySearchTree(root->right, val); 
  
    // if key is same as root's key, then This is the node to be deleted.
    else
    { 
        // node with only one child or no child 
        if (root->left == NULL) 
        { 
            struct tree *temp = root->right; 
            free(root); 
            return temp; 
        } 
        else if (root->right == NULL) 
        { 
            struct tree *temp = root->left; 
            free(root); 
            return temp; 
        } 
  
        //  Get the inorder successor (smallest in the right subtree) for node with two children
        struct tree* temp = minimumtree(root->right); 
        root->data = temp->data; 
        root->right = deleteBinarySearchTree(root->right, temp->data);     // deleting
    } 
    return root;
}

// Function to find the smallest element in binary search tree.
int findSmallestElement(struct tree * root)
{
    
    //The Smallest Element is found in the bottom-left most child of the tree.
    while(root->left != NULL)
    {
        root=root->left;
    }
    return root->data;
}

// Function to find the largest element in binary search tree.
int findLargestElement(struct tree * root)
{

    //The Largest Element is found in the bottom-right most child of the tree.
    while(root->right != NULL)
    {
        root=root->right;
    }
    return root->data;
}

// A function to calculate the total number of elements in Binary Search Tree.
int totalElement(struct tree * root)
{
    
    // If no element in the root means size of tree is 0.
    if(root == NULL)
        return 0;
    else
    {   
        // totalElement(root->left) will recursively call this function and find the size of left sub-tree.
        // totalElement(root->right) will recursively call this function and find the size of right sub-tree. 
        int size = totalElement(root->left) + totalElement(root->right) + 1;
        return size;   
    }
}
int main()
{
    struct tree * root = NULL;
    int ele,smele,larele,totele;
    int choice;
    char ch;
    
    // A menu driven Program to perform following operations as per the user choice.
    do
    {
        cout<<"Perform Operations.\n";
        cout<<"Enter 1 to insert element into binary search tree.\n";
        cout<<"Enter 2 to delete element from binary search tree.\n";
        cout<<"Enter 3 to find the smallest element in the binary search tree.\n";
        cout<<"Enter 4 to find the largest element in the binary search tree.\n";
        cout<<"Enter 5 to calculate total number of elements in the binary search tree.\n";
        cin>>choice;
        switch (choice)
        {
            case 1: cout<<"Enter element to be inserted.\n";
                    cin>>ele;
                    root=insertBinarySearchTree(root,ele);
                    break;
            case 2: cout<<"Enter element to be deleted.\n";
                    cin>>ele;
                    root = deleteBinarySearchTree(root,ele);
                    break;
            case 3: smele = findSmallestElement(root);
                    cout<<"Smallest Element in binary search tree is : "<< smele <<" .\n";
                    break;
            case 4: larele = findLargestElement(root);
                    cout<<"Largest Element in binary search tree is : "<< larele <<" .\n";
                    break;
            case 5: totele = totalElement(root);
                    cout<<"Total number of Elements in binary search tree are : "<< totele <<" .\n";
                    break;
            default: cout<<"Any operations cannot be performed. Please Enter a valid number.\n";
        }
        cout<<"Enter 'y' if you want to perform operations again.\n";
        cin>>ch;
    }while(ch == 'y' || ch == 'Y');
    return 0;
}