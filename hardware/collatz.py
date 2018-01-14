# coding: utf-8

mx1 = 0
mx2 = 0
mx3 = 0
mx4 = 0

len1 = 0
len2 = 0
len3 = 0
len4 = 0

name1 = 0
name2 = 0
name3 = 0
name4 = 0

clock = 0

CACHE_SIZE = 1024
TRACE_CHACHE_ON = True

# 途中通った時にどっから始めた回か？
trace = [0 for i in range(CACHE_SIZE)]
# 途中通った時にそれまでの最大値
tracemx = [0 for i in range(CACHE_SIZE)]
# 最初からのときは最後まで言った時の最大値
memmx = [0 for i in range(CACHE_SIZE)]
memlen = [0 for i in range(CACHE_SIZE)]

for i in range(1, 1024, 2):
#for i in range(1023, 2, -2):
    print("searching...", i)
    data = i
    cnt = 0
    mx = data
    while data != 1:
        clock += 1
        #print(data)
        m = data % 4
        if data == 2:
            cnt += 1
            data = 1
        elif m == 0:
            cnt += 2
            data //= 2
        elif m == 1:
            mx = max(3 * data + 1, mx)
            data = (3 * data + 1) // 4
            cnt += 3
        elif m == 2:
            mx = max(3 * (data // 2) + 1, mx)
            data = (3 * (data // 2) + 1) // 2
            cnt += 3
        else:
            mx = max(3 * data + 1, mx)
            data = (3 * data + 1) // 2
            cnt += 2 # ここもう少し勧められるが...

        if data < CACHE_SIZE:
            if memmx[data] != 0:
                if trace[data] == 0:
                    mx = max(mx, memmx[data])
                    cnt += memlen[data]
                    data = 1
                else:
                    # Traceしてdataまでたどり着いたときの最大値
                    # より、最後まで言った時(trace[data])
                    # の最大値の方がでかかったとき
                    if memmx[data] < memmx[trace[data]]:
                        print('hit')
                        mx = max(mx, memmx[trace[data]])
                        cnt += (memlen[trace[data]] - memlen[data])
                        data = 1
                    elif mx >= memmx[data]:
                        print('hit')
                        data = 1
                        cnt += (memlen[trace[data]] - memlen[data])
                    else:
                        print('諦めた')
            elif TRACE_CHACHE_ON:
                memmx[data] = mx
                memlen[data] = cnt
                trace[data] = i

    memmx[i] = mx
    memlen[i] = cnt
    trace[i] = 0
    if mx1 == mx:
        if len1 < cnt:
            len1 = cnt
            name1 = i
    elif mx2 == mx:
        if len2 < cnt:
            len2 = cnt
            name2 = i
    elif mx3 == mx:
        if len3 < cnt:
            len3 = cnt
            name3 = i
    elif mx4 == mx:
        if len4 < cnt:
            len4 = cnt
            name4 = i

    elif mx1 < mx:
        mx4 = mx3
        mx3 = mx2
        mx2 = mx1
        len4 = len3
        len3 = len2
        len2 = len1
        name4 = name3
        name3 = name2
        name2 = name1
        mx1 = mx
        len1 = cnt
        name1 = i
    elif mx2 < mx:
        mx4 = mx3
        mx3 = mx2
        len4 = len3
        len3 = len2
        name4 = name3
        name3 = name2
        mx2 = mx
        len2 = cnt
        name2 = i
    elif mx3 < mx:
        mx4 = mx3
        len4 = len3
        name4 = name3
        mx3 = mx
        len3 = cnt
        name3 = i
    elif mx4 < mx:
        mx4 = mx
        len4 = cnt
        name4 = i

'''
41524 131 639
118096 62 1023
190996 178 871
250504 173 937
'''
print(name1, name2, name3, name4)
print(len1, len2, len3, len4)
print(mx1, mx2, mx3, mx4)
print('clock', clock)



