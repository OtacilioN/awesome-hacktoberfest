num_1 = int(input('Enter your first number: '))
num_2 = int(input('Enter your second number: '))
 
# Addition
print('{} + {} = '.format(num_1, num_2))
print(num_1 + num_2)
 
# Subtraction
print('{} - {} = '.format(num_1, num_2))
print(num_1 - num_2)
 
# Multiplication
print('{} * {} = '.format(num_1, num_2))
print(num_1 * num_2)
 
# Division
print('{} / {} = '.format(num_1, num_2))
print(num_1 / num_2)

num_1 = int(input('Enter your first number: '))
num_2 = int(input('Enter your second number: '))
 
if choice == '+':
    print('{} + {} = '.format(num_1, num_2))
    print(num_1 + num_2)
 
elif choice == '-':
    print('{} - {} = '.format(num_1, num_2))
    print(num_1 - num_2)
 
elif choice == '*':
    print('{} * {} = '.format(num_1, num_2))
    print(num_1 * num_2)
 
elif choice == '/':
    print('{} / {} = '.format(num_1, num_2))
    print(num_1 / num_2)
 
else:
    print('Enter a valid operator, please run the program again.')
