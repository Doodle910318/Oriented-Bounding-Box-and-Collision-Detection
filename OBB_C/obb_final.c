#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#define pi 3.1415926

struct Vertices_final {
    float x,y,z;
};

struct Vertices {
    float x,y,z;
};

float covariance(float *former_values ,float *latter_values ,int n) {
    float sum = 0.0;
    float mean_former = 0.0 ,mean_latter = 0.0;
    int i;

    // Calculate mean values
    for (i = 0; i < n; i++)
    {
        mean_former += former_values[i];
        mean_latter += latter_values[i];

    }
    mean_former = mean_former / n;
    mean_latter = mean_latter / n;


    // Calculate covariance
    for (i = 0; i < n; i++)
    {
        sum += (former_values[i] - mean_former) * (latter_values[i] - mean_latter);
    }

    return sum / (n - 1);
}

int main()
{
    FILE *Open_Vertices;
    struct Vertices *p;
    int point_number = 0;

    // Open file
    Open_Vertices = fopen("vertices.txt", "r");
    if (Open_Vertices == NULL)
    {
        printf("error\n");
        return 1;
    }

    // Allocate memory dynamically
    p = (struct Vertices*) malloc(sizeof(struct Vertices));

    // Read file and input data to structure
    while (fscanf(Open_Vertices, "%f %f %f",&p[point_number].x ,&p[point_number].y ,&p[point_number].z) != EOF)
    {
        point_number++;
        // Increase memory space dynamically
        p = (struct Vertices*) realloc(p, (point_number + 1) * sizeof(struct Vertices));
    }
    // Close file
    fclose(Open_Vertices);

    float *x_values = (float *)malloc(sizeof(float) * point_number);
    float *y_values = (float *)malloc(sizeof(float) * point_number);
    float *z_values = (float *)malloc(sizeof(float) * point_number);

    for (int i = 0; i < point_number; i++)
    {
        x_values[i] = p[i].x;
        y_values[i] = p[i].y;
        z_values[i] = p[i].z;
    }

    float COV_XX = covariance(x_values ,x_values ,point_number);
    float COV_XY = covariance(x_values ,y_values ,point_number);
    float COV_XZ = covariance(x_values ,z_values ,point_number);
    float COV_YY = covariance(y_values ,y_values ,point_number);
    float COV_YZ = covariance(y_values ,z_values ,point_number);
    float COV_ZZ = covariance(z_values ,z_values ,point_number);

    int k;
        int x,y,z,i,j;
        int sum=1;
        float max,det,a,b;
        float mat[3][3];
        float E[3][3];
        float inverse_E[3][3];
        float M[3][3] = {{COV_XX,COV_XY,COV_XZ},{COV_XY,COV_YY,COV_YZ},{COV_XZ,COV_YZ,COV_ZZ}};  //迭代矩陣(論文中的特徵向量E)
        float I[3][3] = {{100,0,0},{0,100,0},{0,0,100}};
        float II[3][3];
        float D[3][3],R[3][3];
        printf("我是COV:\n");
        for(x=0;x<3;x++)
        {
            for(y=0;y<3;y++)
            {
                printf(" %.6f ",M[x][y]);
            }
            printf("\n");
        }
    for(k=0;k<4;k++) // (n^2-n) / 2 次
    {
        det = 0;
        for(x=0;x<3;x++)
        {
            for(y=0;y<3;y++)
            {
                if(x==y)
                {
                    D[x][y] = M[x][y];  //D為對角線矩陣 R為非對角線矩陣
                    R[x][y] = 0;
                }
                else
                {
                    D[x][y] = 0;
                    R[x][y] = M[x][y];
                }
            }
        }


        //其餘部分找絕對值最大值
        max = 0;
        for(x=0;x<2;x++)
        {
            for(y=1;y<3;y++)
            {
                a = fabs(R[x][y]);
                b = fabs(max);
                if (a > b)
                {
                    max = R[x][y];
                    i = x;
                    j = y;
                }
            }
        }

    printf("\n");
    //旋轉角度
    float rotation_angle;

        rotation_angle = atan2(2*R[i][j],D[j][j]-D[i][i]);

        if(R[i][j]>=0 && (D[j][j] - D[i][i])<0)
        {
            rotation_angle = (rotation_angle - pi)*0.5;
        }
        else if(R[i][j]<0 && (D[j][j] - D[i][i])<0)
        {
            rotation_angle = (rotation_angle + pi)*0.5;
        }
        else
        {
              rotation_angle = rotation_angle *0.5;
        }

        //括號內為弧度
        for(x=0;x<3;x++)
        {
            for(y=0;y<3;y++)
            {
                    E[x][y] = 0;
            }
        }
        //建立旋轉矩陣E
            E[i][j] = 100*sin(rotation_angle);
            E[j][i] = 100*(-sin(rotation_angle));
            E[i][i] = 100*cos(rotation_angle);
            E[j][j] = 100*cos(rotation_angle);
            E[3-i-j][3-i-j] = 100;
            printf("%d %d",i,j);
        printf("\n");
       printf("第 %d 次:",sum);
       sum++;
       if(3-i-j==0)
       {
           printf("空間繞x軸旋轉:\n\n");
       }
       else if (3-i-j==1)
       {
           printf("空間繞y軸旋轉:\n\n");
       }
       else
       {
           printf("空間繞z軸旋轉:\n\n");
       }
       for(x=0;x<3;x++)
        {
            for(y=0;y<3;y++)
            {
                printf(" %.4f ",E[x][y]);
            }
            printf("\n");
        }

        printf("\n選轉角度: %.2f  度\n\n",rotation_angle*180/pi);

        for(x=0;x<3;x++)
        {
            for(y=0;y<3;y++)
            {
                II[x][y] = 0;
            }
        }
         for(x=0;x<3;x++)
        //矩陣相乘 II = E * I
        for (x = 0; x < 3; x++)
        {
            for (y = 0; y < 3; y++)
            {
                for (z = 0; z < 3; z++)
                {
                    II[x][y] += E[x][z] * I[z][y];
                }
            }
        }
        for(x=0;x<3;x++)
        {
            for(y=0;y<3;y++)
            {
                I[x][y] = II[x][y]/10;
            }
        }
        printf("我是I:\n");
        for(x=0;x<3;x++)
        {
            for(y=0;y<3;y++)
            {
                printf(" %.6f ",I[x][y]);
            }
            printf("\n");
        }
        printf("\n");

        // 計算轉置矩陣
        for (x = 0; x < 3; x++)
        {
            for (y = 0; y < 3; y++)
            {
                inverse_E[x][y] = E[y][x];
            }
        }

        //矩陣相乘 mat = E轉置 * M * E
        printf("我是ET:\n");
        for(x=0;x<3;x++)
        {
            for(y=0;y<3;y++)
            {
                printf(" %.6f ",inverse_E[x][y]);
            }
            printf("\n");
        }
        printf("\n");
        printf("我是M:\n");
        for(x=0;x<3;x++)
        {
            for(y=0;y<3;y++)
            {
                printf(" %.6f ",M[x][y]);
            }
            printf("\n");
        }
        printf("\n");

        for (x = 0; x < 3; x++)
        {
            for (y = 0; y < 3; y++)
            {
                mat[x][y] = 0;
                for (z = 0; z < 3; z++)
                {
                    mat[x][y] += inverse_E[x][z] * M[z][y]/1000;
                }
            }
        }
        printf("我是ET*M:\n");
        for(x=0;x<3;x++)
        {
            for(y=0;y<3;y++)
            {
                printf(" %.2f ",mat[x][y]);
            }
            printf("\n");
        }
        printf("\n");
        //矩陣相乘 M = mat * E

        for (x = 0; x < 3; x++)
        {
            for (y = 0; y < 3; y++)
            {
                M[x][y] = 0;
                for (z = 0; z < 3; z++)
                {
                    M[x][y] += mat[x][z] * E[z][y];
                }
            }
        }
        printf("我是ET*M*E:\n");
        for(x=0;x<3;x++)
        {
            for(y=0;y<3;y++)
            {
                printf(" %.2f ",M[x][y]);
            }
            printf("\n");
        }
    }
        printf("\n特徵向量:\n");

        for(x=0;x<3;x++)
        {
            for(y=0;y<3;y++)
            {
                printf(" %.6f ",I[x][y]);
            }
            printf("\n");
        }
        printf("\n");

    //Start Projection  (￣ε(#￣)☆╰╮o(￣皿￣///)
    float new_axes[3][3];

    printf("Eigenvector\n");

    for(int i = 0 ; i < 3 ; i++)
    {
        for(int j = 0 ; j < 3 ; j++)
        {
            new_axes[i][j] = I[j][i];
            printf("%f ",new_axes[i][j]);
        }
        printf("\n");
    }


    float x_new[point_number][3], y_new[point_number][3], z_new[point_number][3];
    float new_point;

    //find projection point
    //new_axes[i][0]
    for(int i = 0 ;i < point_number ;i++)
    {
        float magnitude;
        magnitude = ((x_values[i] * new_axes[0][0])+(y_values[i] * new_axes[1][0])+(z_values[i] * new_axes[2][0]))/
        ((new_axes[0][0]*new_axes[0][0])+(new_axes[1][0]*new_axes[1][0])+(new_axes[2][0]*new_axes[2][0])) ;

        x_new[i][0] = magnitude * new_axes[0][0]; //new x-axis's x
        x_new[i][1] = magnitude * new_axes[1][0]; //new x-axis's y
        x_new[i][2] = magnitude * new_axes[2][0]; //new x-axis's z
    }

    //new_axes[i][1]
    for(int i = 0 ;i < point_number ;i++)
    {
        float magnitude;
        magnitude = ((x_values[i] * new_axes[0][1])+(y_values[i] * new_axes[1][1])+(z_values[i] * new_axes[2][1]))/
        ((new_axes[0][1]*new_axes[0][1])+(new_axes[1][1]*new_axes[1][1])+(new_axes[2][1]*new_axes[2][1])) ;

        y_new[i][0] = magnitude * new_axes[0][1];
        y_new[i][1] = magnitude * new_axes[1][1];
        y_new[i][2] = magnitude * new_axes[2][1];
    }

    //new_axes[i][2]
    for(int i = 0 ;i < point_number ;i++)
    {
        float magnitude;
        magnitude = ((x_values[i] * new_axes[0][2])+(y_values[i] * new_axes[1][2])+(z_values[i] * new_axes[2][2]))/
        ((new_axes[0][2]*new_axes[0][2])+(new_axes[1][2]*new_axes[1][2])+(new_axes[2][2]*new_axes[2][2])) ;
        z_new[i][0] = magnitude * new_axes[0][2];
        z_new[i][1] = magnitude * new_axes[1][2];
        z_new[i][2] = magnitude * new_axes[2][2];
    }

    //find center using max and min x value
    //axis1
    float max_axis1 = x_new[0][0];
    float min_axis1 = x_new[0][0];
    int max_axis1_number = 0, min_axis1_number = 0;
    for(int i = 1 ;i < point_number ;i++)
    {
        if(x_new[i][0] > max_axis1)
        {
            max_axis1 = x_new[i][0];
            max_axis1_number = i;
        }
        if(x_new[i][0] < min_axis1)
        {
            min_axis1 = x_new[i][0];
            min_axis1_number = i;
        }
    }
    float V_axis1_proj_center[3] = {(x_new[max_axis1_number][0]+x_new[min_axis1_number][0])/2, (x_new[max_axis1_number][1]+x_new[min_axis1_number][1])/2, (x_new[max_axis1_number][2]+x_new[min_axis1_number][2])/2};


    float max_axis2 = y_new[0][0], min_axis2 = y_new[0][0];
    int max_axis2_number = 0, min_axis2_number = 0;
    for(int i = 1 ;i < point_number ;i++)
    {
        if(y_new[i][0] > max_axis2)
        {
            max_axis2 = y_new[i][0];
            max_axis2_number = i;
        }
        if(y_new[i][0] < min_axis2)
        {
            min_axis2 = y_new[i][0];
            min_axis2_number = i;
        }
    }
    float V_axis2_proj_center[3] = {(y_new[max_axis2_number][0]+y_new[min_axis2_number][0])/2, (y_new[max_axis2_number][1]+y_new[min_axis2_number][1])/2, (y_new[max_axis2_number][2]+y_new[min_axis2_number][2])/2};

    float max_axis3 = z_new[0][0], min_axis3 = z_new[0][0];
    int max_axis3_number = 0, min_axis3_number = 0;
    for(int i = 1 ;i < point_number ;i++)
    {
        if(z_new[i][0] > max_axis3)
        {
            max_axis3 = z_new[i][0];
            max_axis3_number = i;
        }
        if(z_new[i][0] < min_axis3)
        {
            min_axis3 = z_new[i][0];
            min_axis3_number = i;
        }
    }
    float V_axis3_proj_center[3] = {(z_new[max_axis3_number][0]+z_new[min_axis3_number][0])/2, (z_new[max_axis3_number][1]+z_new[min_axis3_number][1])/2, (z_new[max_axis3_number][2]+z_new[min_axis3_number][2])/2};
    float Vcenter[3];
    Vcenter[0] = (V_axis1_proj_center[0] + V_axis2_proj_center[0] + V_axis3_proj_center[0]);
    Vcenter[1] = (V_axis1_proj_center[1] + V_axis2_proj_center[1] + V_axis3_proj_center[1]);
    Vcenter[2] = (V_axis1_proj_center[2] + V_axis2_proj_center[2] + V_axis3_proj_center[2]);

    float radias1, radias2, radias3, radias_axes1, radias_axes2, radias_axes3;

    radias1 = sqrt(((V_axis1_proj_center[0]-x_new[max_axis1_number][0])*(V_axis1_proj_center[0]-x_new[max_axis1_number][0])) + ((V_axis1_proj_center[1]-x_new[max_axis1_number][1])
    *(V_axis1_proj_center[1]-x_new[max_axis1_number][1])) + ((V_axis1_proj_center[2]-x_new[max_axis1_number][2])*(V_axis1_proj_center[2]-x_new[max_axis1_number][2])));

    radias2 = sqrt(((V_axis2_proj_center[0]-y_new[max_axis2_number][0])*(V_axis2_proj_center[0]-y_new[max_axis2_number][0])) + ((V_axis2_proj_center[1]-y_new[max_axis2_number][1])
    *(V_axis2_proj_center[1]-y_new[max_axis2_number][1])) + ((V_axis2_proj_center[2]-y_new[max_axis2_number][2])*(V_axis2_proj_center[2]-y_new[max_axis2_number][2])));

    radias3 = sqrt(((V_axis3_proj_center[0]-z_new[max_axis3_number][0])*(V_axis3_proj_center[0]-z_new[max_axis3_number][0])) + ((V_axis3_proj_center[1]-z_new[max_axis3_number][1])
    *(V_axis3_proj_center[1]-z_new[max_axis3_number][1])) + ((V_axis3_proj_center[2]-z_new[max_axis3_number][2])*(V_axis3_proj_center[2]-z_new[max_axis3_number][2])));

    radias_axes1 = sqrt((new_axes[0][0]*new_axes[0][0]) + (new_axes[0][1]*new_axes[0][1]) + (new_axes[0][2]*new_axes[0][2]));
    radias_axes2 = sqrt((new_axes[1][0]*new_axes[1][0]) + (new_axes[1][1]*new_axes[1][1]) + (new_axes[1][2]*new_axes[1][2]));
    radias_axes3 = sqrt((new_axes[2][0]*new_axes[2][0]) + (new_axes[2][1]*new_axes[2][1]) + (new_axes[2][2]*new_axes[2][2]));

    radias1 = radias1 / radias_axes1;
    radias2 = radias2 / radias_axes2;
    radias3 = radias3 / radias_axes3;



    //printf("\n\n%f %f %f",axis3_positive_point[0],axis3_positive_point[1],axis3_positive_point[2]);

    printf("\n");

    float OBB_point[8][3];

    OBB_point[0][0] = Vcenter[0] +( radias1 * (new_axes[0][0]) + radias2 * (new_axes[0][1]) + radias3 * (new_axes[0][2]));
    OBB_point[0][1] = Vcenter[1] +( radias1 * (new_axes[1][0]) + radias2 * (new_axes[1][1]) + radias3 * (new_axes[1][2]));
    OBB_point[0][2] = Vcenter[2] +( radias1 * (new_axes[2][0]) + radias2 * (new_axes[2][1]) + radias3 * (new_axes[2][2]));

    OBB_point[1][0] = Vcenter[0] +( radias1 * (new_axes[0][0]) + radias2 * (new_axes[0][1]) - radias3 * (new_axes[0][2]));
    OBB_point[1][1] = Vcenter[1] +( radias1 * (new_axes[1][0]) + radias2 * (new_axes[1][1]) - radias3 * (new_axes[1][2]));
    OBB_point[1][2] = Vcenter[2] +( radias1 * (new_axes[2][0]) + radias2 * (new_axes[2][1]) - radias3 * (new_axes[2][2]));

    OBB_point[2][0] = Vcenter[0] +( radias1 * (new_axes[0][0]) - radias2 * (new_axes[0][1]) + radias3 * (new_axes[0][2]));
    OBB_point[2][1] = Vcenter[1] +( radias1 * (new_axes[1][0]) - radias2 * (new_axes[1][1]) + radias3 * (new_axes[1][2]));
    OBB_point[2][2] = Vcenter[2] +( radias1 * (new_axes[2][0]) - radias2 * (new_axes[2][1]) + radias3 * (new_axes[2][2]));

    OBB_point[3][0] = Vcenter[0] +( radias1 * (new_axes[0][0]) - radias2 * (new_axes[0][1]) - radias3 * (new_axes[0][2]));
    OBB_point[3][1] = Vcenter[1] +( radias1 * (new_axes[1][0]) - radias2 * (new_axes[1][1]) - radias3 * (new_axes[1][2]));
    OBB_point[3][2] = Vcenter[2] +( radias1 * (new_axes[2][0]) - radias2 * (new_axes[2][1]) - radias3 * (new_axes[2][2]));

    OBB_point[4][0] = Vcenter[0] +( -radias1 * (new_axes[0][0]) + radias2 * (new_axes[0][1]) + radias3 * (new_axes[0][2]));
    OBB_point[4][1] = Vcenter[1] +( -radias1 * (new_axes[1][0]) + radias2 * (new_axes[1][1]) + radias3 * (new_axes[1][2]));
    OBB_point[4][2] = Vcenter[2] +( -radias1 * (new_axes[2][0]) + radias2 * (new_axes[2][1]) + radias3 * (new_axes[2][2]));

    OBB_point[5][0] = Vcenter[0] +( -radias1 * (new_axes[0][0]) + radias2 * (new_axes[0][1]) - radias3 * (new_axes[0][2]));
    OBB_point[5][1] = Vcenter[1] +( -radias1 * (new_axes[1][0]) + radias2 * (new_axes[1][1]) - radias3 * (new_axes[1][2]));
    OBB_point[5][2] = Vcenter[2] +( -radias1 * (new_axes[2][0]) + radias2 * (new_axes[2][1]) - radias3 * (new_axes[2][2]));

    OBB_point[6][0] = Vcenter[0] +( -radias1 * (new_axes[0][0]) - radias2 * (new_axes[0][1]) + radias3 * (new_axes[0][2]));
    OBB_point[6][1] = Vcenter[1] +( -radias1 * (new_axes[1][0]) - radias2 * (new_axes[1][1]) + radias3 * (new_axes[1][2]));
    OBB_point[6][2] = Vcenter[2] +( -radias1 * (new_axes[2][0]) - radias2 * (new_axes[2][1]) + radias3 * (new_axes[2][2]));

    OBB_point[7][0] = Vcenter[0] +( -radias1 * (new_axes[0][0]) - radias2 * (new_axes[0][1]) - radias3 * (new_axes[0][2]));
    OBB_point[7][1] = Vcenter[1] +( -radias1 * (new_axes[1][0]) - radias2 * (new_axes[1][1]) - radias3 * (new_axes[1][2]));
    OBB_point[7][2] = Vcenter[2] +( -radias1 * (new_axes[2][0]) - radias2 * (new_axes[2][1]) - radias3 * (new_axes[2][2]));


    for(x=0;x<8;x++)
    {
        for(y=0;y<3;y++)
        {
            printf("%f ",OBB_point[x][y]);
        }
        printf("\n");
    }


    return 0;
}

