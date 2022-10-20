#include <stdio.h>
int main()
{
  int c, first, last, middle, n, search, array[100];

  printf("\n\nEnter number of elements : ");
  scanf("%d", &n);

  printf("\n\nEnter %d integers : ", n);

  for (c = 0; c < n; c++)
    scanf("%d", &array[c]);

  printf("\n\nEnter value to find : ");
  scanf("%d", &search);

  first = 0;
  last = n - 1;
  middle = (first+last)/2;

  while (first <= last) {
    if (array[middle] < search)
      first = middle + 1;
    else if (array[middle] == search) {
      printf("\nItem %d found at location %d.", search, middle+1);
      break;
    }
    else
      last = middle - 1;

    middle = (first + last)/2;
  }
  if (first > last)
    printf("\nNot found! %d isn't present in the list.", search);

  return 0;
}