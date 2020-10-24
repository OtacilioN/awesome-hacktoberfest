/*
Write a program to create a binary search tree and perform the following operation on it: 
Find the number of internal nodes, number of external nodes, and height of the tree, print the elements in the decreasing order, and obtain the mirror image of the tree.
A mirror image is obtained by interchanging the left sub-tree with right sub-tree. The program should contain at least the following functions:
1. externalNodesTotal( ) // This function will return the total number of external nodes.
2. internalNodesTotal( ) // This function will return the total number of internal nodes.
3. treeHeight() // This function will return the height of the tree.
4. printDecreasingOrder() // This function will print the elements in decreasing order.
5. treeMirrorImage() // This function will return the mirror image of the given tree.
You need to find out the parameters that must be passed to the above functions, and the return type of each function, 
to carry out the intended operation. Write the necessary function to test the mirror image of the tree. Also mention in your program, 
the function used to test the mirror image of the tree. Test your program before uploading.
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

// function to count number of external nodes
int externalNodesTotal( struct tree * root )
{
    // Base case , if tree is empty
    if( root == NULL )
        return 0;
    
    // check for leaf nodes and increase count to 1
    if( root->left == NULL && root->right == NULL )
        return 1;
    else
    {
        // recursively check for left and right sub tree
        return (externalNodesTotal(root->left) + externalNodesTotal(root->right));
    }
    
}
// function to count number of internal nodes
int internalNodesTotal ( struct tree * root )
{
    // Base Case,  if tree is empty or if it is a leaf
    if(root == NULL || ( root->left == NULL && root->right == NULL ) )
        return 0;
    
    // recursively check for left and right sub tree
    return ( internalNodesTotal(root->left) + internalNodesTotal(root->right) + 1 );
}

// function to calculate height of tree
int treeHeight( struct tree * root )
{
    if (root == NULL)  
        return 0;  
    else
    {  
        // computing the depth of each subtree 
        int lef = treeHeight(root->left);  
        int rig = treeHeight(root->right);  
      
        //using the larger one 
        if ( lef > rig )  
            return (lef + 1);  
        else 
            return (rig + 1);  
    }
}

// function to store mirror image to another tree
void treeMirrorImage(struct tree * root, struct tree ** mirror) 
{ 
    // base case if tree is empty
    if (root == NULL) 
    { 
        mirror = NULL; 
        return; 
    } 
    
    struct tree * ptr = createBinarySearchTree();
    ptr->data = root->data;
    // Create new mirror node from original tree node 
    *mirror = ptr;

    // recursively store left subtree of original to right of mirror and vice veresa.
    treeMirrorImage(root->left, &((*mirror)->right)); 
    treeMirrorImage(root->right, &((*mirror)->left)); 
}

// function to traverse the binary tree in Inorder
void inOrder(struct tree * root)  
{ 
    if (root == NULL)  
        return; 
      
    inOrder(root->left); 
    cout << root->data << "   "; 
    inOrder(root->right); 
}

//Function to print tree elements Of BST in decreasing order.
void printDecreasingOrder ( struct tree * root )
{
    // Base case, if tree is empty.
    if (root == NULL)  
        return; 

    // Just the reverse printing of inorder traversal that yields elements of BST in decreasing order  
    printDecreasingOrder(root->right); 
    cout << root->data << "   "; 
    printDecreasingOrder(root->left);
}

// Function to compare whether two tree are mirrors.
int areMirror(struct tree * root, struct tree * mirror) 
{ 
    //Base case : Both empty 
    if (root == NULL && mirror == NULL) 
        return 1; 
  
    // If only one is empty 
    if (root == NULL || mirror == NULL) 
        return 0; 
  
    //Both non-empty, we compare them recursively 
    if( root->data == mirror->data && areMirror(root->left, mirror->right) && areMirror(root->right, mirror->left))
        return 1;
    else
        return 0;
     
}

// Main Function... User code.
int main()
{
    struct tree * root = NULL;
    int ele,extnode,intnode,height;
    int choice;
    char ch;
    
    cout<<"Perform Operations.\n";
    cout<<"Enter 1 to insert element into binary search tree.\n";
    cout<<"Enter 2 to delete element from binary search tree.\n";
    cout<<"Enter 3 to find total number of external nodes in the binary search tree.\n";
    cout<<"Enter 4 to find total number of internal nodes in the binary search tree.\n";
    cout<<"Enter 5 to calculate the height of the binary search tree.\n";
    cout<<"Enter 6 to print the elements of binary search tree in Decreasing order.\n";
    cout<<"Enter 7 to obtain the mirror image of the binary search tree.\n";
    cout<<"Enter 8 to test for mirror image of the binary search tree.\n";
    // A menu driven Program to perform following operations as per the user choice.
    do
    {
        cout<<"Enter your choice!!!\n";
        cin>>choice;
        struct tree * mirror = NULL;
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
            case 3: extnode = externalNodesTotal(root);
                    cout<<"Total number of external nodes in binary search tree are : "<< extnode <<" .\n";
                    break;
            case 4: intnode = internalNodesTotal(root);
                    cout<<"Total number of internal nodes in binary search tree are : "<< intnode <<" .\n";
                    break;
            case 5: height = treeHeight(root);
                    cout<<"Height of binary search tree is : "<< height <<" .\n";
                    break;
            case 6: printDecreasingOrder( root );
                    cout<<"\n";
                    break;
            case 7: treeMirrorImage( root, &mirror );
                    cout<<" Before Mirror Inorder Traversal: \n";
                    inOrder( root );
                    cout<<"\n";
                    cout<<" After Mirror Inorder Traversal: \n";
                    inOrder( mirror );
                    cout<<"\n";
                    break;
            case 8: treeMirrorImage( root, &mirror );
                    cout<<" Original Tree Inorder Traversal: \n";
                    inOrder( root );
                    cout<<"\n";
                    cout<<" Mirror Tree Inorder Traversal: \n";
                    inOrder( mirror );
                    cout<<"\n";
                    if (areMirror( root, mirror ))
                        cout<<" Tree are Mirrors\n";
                    else
                        cout<<"Trees are not Mirrors\n";
                    break;
            default: cout<<"Any operations cannot be performed. Please Enter a valid number.\n";
        }
        cout<<"Enter 'y' if you want to perform operations again.\n";
        cin>>ch;
    }while(ch == 'y' || ch == 'Y');
    return 0;
}