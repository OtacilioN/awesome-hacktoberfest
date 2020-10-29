import java.util.*;
class Kruskal2
{
    int mincost=0;
    public int find(int w, int parent[])
    {
        while(parent[w]!=0)
        w=parent[w];
        return w;
    }
    public int union(int u, int v, int parent[], int noe, int a, int b, int cost[][], int min)
    {
        if(u!=v)
        {
            noe++;
            System.out.println(noe-1+" Edge ("+a+","+b+") = " +min);
            mincost+=min;
            parent[v]=u;
        }
        cost[a][b]=cost[b][a] =999;
        return noe;
        }
}
public class Kruskal 
{   
    public static void main(String args[])
    {
        Kruskal2 ob = new Kruskal2();
        int parent[] = new int[50];
        int cost[][]=new int[10][10];   
        int a=0, b=0,i,j,u=0,v=0,min,noe=1;
        Scanner s=new Scanner(System.in);
        System.out.println("Enter the number of vertices");
        int n=s.nextInt();
        System.out.println("Enter the cost adjacency matrix, 999 for no direct path");
        for(i=1;i<=n;i++)
        {
            for(j=1;j<=n;j++)
            {
                cost[i][j]=s.nextInt();
            }
        }
                while(noe<n)
                {
                    min=999;
                    for(i=1;i<=n;i++)
                    {
                        for(j=1;j<=n;j++)
                            {
                                if(cost[i][j]<min)
                                {
                                    min=cost[i][j];
                                    a=u=i;
                                    b=v=j;
                                }
                            }
                        }
                    u=ob.find(u, parent);
                    v=ob.find(v, parent);
                    noe=ob.union(u,v,parent,noe,a,b,cost,min);
                }
                System.out.println("Minimum cost = "+ob.mincost);
            }
        }
        
