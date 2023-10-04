#include <iostream>
#include <bits/stdc++.h>
using namespace std;

class Node
{
public:
    int data;
    Node *next;

    Node(int data)
    {

        this->data = data;
        this->next = NULL;
    };
};

// Two Pointer Efficient Approach
// T.C. -> O(N)
// S.C. -> O(1)
Node *removeNthFromEnd(Node *head, int n)
{

    Node *start = new Node(0);
    start->next = head;
    Node *fast = start;
    Node *slow = start;

    // Till fast pointer reaches n-th node
    for (int i = 1; i <= n; i++)
        fast = fast->next;

    while (fast->next != NULL)
    {
        fast = fast->next;
        slow = slow->next;
    }

    // Disconnect the given Node
    slow->next = slow->next->next;

    return start->next;
}

void print(Node *&head)
{
    Node *temp = head;
    while (temp != NULL)
    {
        cout << " " << temp->data << " ";
        temp = temp->next;
    }
}

void push(Node *&head, int data)
{
    if (head == NULL)
    {
        head = new Node(data);
    }

    else
    {

        Node *temp = new Node(data);
        temp->next = head;
        head = temp;
    }
}

int main()
{
    Node *temp = new Node(5);
    Node *head = temp;

    push(head, 4);
    push(head, 3);
    push(head, 2);
    push(head, 1);

    cout << " Given Linked List is: " << endl;
    print(head);

    Node *res = removeNthFromEnd(head, 2);
    cout << "\n Linked List After Removing 2nd node From End is: " << endl;
    print(head);

    return 0;
}