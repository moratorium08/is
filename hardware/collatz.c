#include <stdio.h>
#include <time.h>

const int loop = 10000;

int max(int a, int b) {
    if (a > b) return a;
    return b;
}
int mx1 = 0;
int mx2 = 0;
int mx3 = 0;
int mx4 = 0;

int len1 = 0;
int len2 = 0;
int len3 = 0;
int len4 = 0;

int name1 = 0;
int name2 = 0;
int name3 = 0;
int name4 = 0;

int trace[2048] = {0};
int memmx[2048] = {0};
int memlen[2048] = {0};


int main() {
    int i = 1;
    int j = 1;
    clock_t start, end;

    int sum = 0;
    for (; j < loop; j++) {
        start = clock();
        for (i = 1; i < 1024; i+=2) {
            //printf("searching %d\n", i);
            int data = i;
            int cnt = 0;
            int mx = data;

            while (data != 1) {
                //printf("%d\n", data);
                int m = data % 4;
                if (data == 2) {
                    cnt += 1;
                    data = 1;
                } else if (m == 0) {
                    cnt += 2;
                    data /= 4;
                } else if (m == 1) {
                    mx = max(mx, 3 * data + 1);
                    data = (3 * data + 1) / 4;
                    cnt += 3;
                } else if (m == 2) {
                    mx = max(3 * (data / 2) + 1, mx);
                    data = ( 3 * (data / 2) + 1) / 2;
                    cnt += 3;
                } else {
                    mx = max(3 * (( 3 * data + 1) / 2) + 1, mx);
                    data = (3 * ((3 * data + 1) / 2) + 1) / 2;
                    cnt += 4;
                }
                if (data < 2048) {
                    if (memmx[data] != 0) {
                        if (trace[data] == 0) {
                            mx = max(mx, memmx[data]);
                            cnt += memlen[data];
                            data = 1;
                        } else {
                            if (memmx[data] < memmx[trace[data]]) {
                                mx = max(mx, memmx[trace[data]]);
                                cnt += (memlen[trace[data]] - memlen[data]);
                                data = 1;
                            } else if (mx >= memmx[data]) {
                                cnt += (memlen[trace[data]] - memlen[data]);
                                data = 1;
                            }
                        }
                    }
                    else {
                        memmx[data] = mx;
                        memlen[data] = cnt;
                        trace[data] = i;
                    }

                }
            }
            memmx[i] = mx;
            memlen[i] = cnt;
            trace[i] = 0;

            if (mx1 == mx) {
                if (len1 < cnt) {
                    len1 = cnt;
                    name1 = i;
                }
            }
            else if (mx2 == mx) {
                if (len2 < cnt) {
                    len2 = cnt;
                    name2 = i;
                }
            }
            else if (mx3 == mx) {
                if (len3 < cnt) {
                    len3 = cnt;
                    name3 = i;
                }
            }
            else if (mx4 == mx) {
                if (len4 < cnt) {
                    len4 = cnt;
                    name4 = i;
                }
            }
            else if (mx1 < mx) {
                mx4 = mx3;
                mx3 = mx2;
                mx2 = mx1;
                len4 = len3;
                len3 = len2;
                len2 = len1;
                name4 = name3;
                name3 = name2;
                name2 = name1;
                mx1 = mx;
                len1 = cnt;
                name1 = i;
            }
            else if (mx2 < mx) {
                mx4 = mx3;
                mx3 = mx2;
                len4 = len3;
                len3 = len2;
                name4 = name3;
                name3 = name2;
                mx2 = mx;
                len2 = cnt;
                name2 = i;
            }
            else if (mx3 < mx) {
                mx4 = mx3;
                len4 = len3;
                name4 = name3;
                mx3 = mx;
                len3 = cnt;
                name3 = i;
            }
            else if (mx4 < mx) {
                mx4 = mx;
                len4 = cnt;
                name4 = i;
            }
        }
        if (name4 != 639) {
            printf("error %d\n", name4);
        }
        end = clock();
        printf("%d\n", j);
        //printf("%d, %d, %d, %d\n", name1, name2, name3, name4);
        //printf("%d, %d, %d, %d\n", len1, len2, len3, len4);
        //printf("%d, %d, %d, %d\n", mx1, mx2, mx3, mx4);
        sum += (end - start);
        int k=0;
        mx1 = 0;
        mx2 = 0;
        mx3 = 0;
        mx4 = 0;

        len1 = 0;
        len2 = 0;
        len3 = 0;
        len4 = 0;

        name1 = 0;
        name2 = 0;
        name3 = 0;
        name4 = 0;
        for(k = 0; k < 2048; k++) {
            trace[k] = 0;
            memmx[k] = 0;
            memlen[k] = 0;
        }
    }

    printf("%f clocks\n", sum * 2.3E9 / CLOCKS_PER_SEC / loop);
    return 0;
}
