
__global__ void kernel(float *x)
{
  x[0] = 0;
}

void foo() {

  float *x;

  kernel<<<1,1>>>(x);
}