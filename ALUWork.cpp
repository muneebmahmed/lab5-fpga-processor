#include <iostream>
#include <string>
#include <cmath>

using namespace std;

static const long hextable[] = { 
    -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
    -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
    -1,-1, 0,1,2,3,4,5,6,7,8,9,-1,-1,-1,-1,-1,-1,-1,10,11,12,13,14,15,-1,
    -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
    -1,-1,10,11,12,13,14,15,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
    -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
    -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
    -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
    -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
    -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
    -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
};

/** 
 * @brief convert a hexidecimal string to a signed long
 * will not produce or process negative numbers except 
 * to signal error.
 * 
 * @param hex without decoration, case insensitive. 
 * 
 * @return -1 on error, or result (max (sizeof(long)*8)-1 bits)
 */
long hexdec( const char *hex) {
   long ret = 0; 
   while (*hex && ret >= 0) {
      ret = (ret << 4) | hextable[*hex++];
   }
   return ret; 
}

    static const int debruijn32[32] = {
        0, 31, 9, 30, 3, 8, 13, 29, 2, 5, 7, 21, 12, 24, 28, 19,
        1, 10, 4, 14, 6, 22, 25, 20, 11, 15, 23, 26, 16, 27, 17, 18
    };

string dechex(unsigned int dec){
    string ret = "";
    string digits = "0123456789ABCDEF";
    int digit = dec%16;
    while (dec != 0){
        digit = dec%16;
        ret = digits[digit] + ret;
        dec /= 16;
    }
    return ret;
}

unsigned int rotr( long A, unsigned int B){
    unsigned int ret;
    B %= 32;
    long bPower = pow(2, B);
    ret = (unsigned int)A%bPower;
    ret *= pow(2, 32-B);
    A >>= B;
    ret += A;
    return ret;
}

int main (void){

	string cont = "yes";
    int aluControl = 0;
    string inputA, inputB;
    unsigned int decA, decB, result, zero;
    long longResult = 0;
    const long MAX_32 = pow(2, 32);
    unsigned int x, count = 0;
    while (cont.compare("y")== 0 || cont.compare("yes")==0 || cont.compare("Yes")==0 || cont.compare("Y")==0){
        //cout << "Enter aluControl (decimal integer): ";
        //cin >> aluControl;
        cout << "Enter input A (Hexadecimal): ";
        cin >> inputA;
        cout << "Enter input B (Hexadecimal): ";
        cin >> inputB;
        decA = (unsigned int)hexdec(inputA.c_str());
        decB = (unsigned int)hexdec(inputB.c_str());
        for (aluControl = 0; aluControl < 13; aluControl++){
        cout << "The answer for aluControl "<< aluControl <<" is:\t ";
        switch (aluControl){
            case 0:
                result = decA+decB;
                cout << "Decimal: " << result << "\tHex: " << dechex(result);
                zero = (result == 0);
                cout << "\nZero: " << zero << endl;
                break;
            case 1:
                result = decA-decB;
                cout << "Decimal: " << result << "\tHex: " << dechex(result);
                zero = (result == 0);
                cout << "\nZero: " << zero << endl;
                break;
            case 2:
                longResult = (long)decA;
                longResult *= (long)decB;
                longResult %= MAX_32;
                result = (unsigned int)longResult;
                cout << "Decimal: " << result << "\tHex: " << dechex(result);
                zero = (result == 0);
                cout << "\nZero: " << zero << endl;
                break;
            case 3:
                result = decA & decB;
                cout << "Decimal: " << result << "\tHex: " << dechex(result);
                zero = (result == 0);
                cout << "\nZero: " << zero << endl;
                break;
            case 4:
                result = decA | decB;
                cout << "Decimal: " << result << "\tHex: " << dechex(result);
                zero = (result == 0);
                cout << "\nZero: " << zero << endl;
                break;
            case 5:
                result = (decA < decB)? 1 : 0;
                cout << "Decimal: " << result << "\tHex: " << dechex(result);
                zero = (result == 0);
                cout << "\nZero: " << zero << endl;
                break;
            case 6:
                result = (decA == decB)? 1 : 0;
                cout << "Decimal: " << result << "\tHex: " << dechex(result);
                zero = (result == 0);
                cout << "\nZero: " << zero << endl;
                break;
            case 7:
                result = (decA != decB)? 1 : 0;
                cout << "Decimal: " << result << "\tHex: " << dechex(result);
                zero = (result == 0);
                cout << "\nZero: " << zero << endl;
                break;
            case 8:
                result = decA << decB;
                cout << "Decimal: " << result << "\tHex: " << dechex(result);
                zero = (result == 0);
                cout << "\nZero: " << zero << endl;
                break;
            case 9:
                result = decA >> decB;
                cout << "Decimal: " << result << "\tHex: " << dechex(result);
                zero = (result == 0);
                cout << "\nZero: " << zero << endl;
                break;
            case 10:
                //result = rotr(decA, decB);
                //decB %= 32;
                result = ((decA >> decB) | (decA << (32-decB)));
                cout << "Decimal: " << result << "\tHex: " << dechex(result);
                zero = (result == 0);
                cout << "\nZero: " << zero << endl;
                break;
            case 11:
                x = ~decA;
                x |= x>>1;
                x |= x>>2;
                x |= x>>4;
                x |= x>>8;
                x |= x>>16;
                x++;
                x = (x*124511785) >> 27;
                result = debruijn32[x];
                if (~decA == 0){
                    result = 32;
                }
//                x = decA, count = 0;
//                for (unsigned int i = 16; i; i >>= 1){
//                    if (!(x >> i)){ //use | reduction operator in verilog
//                        count += i;
//                    }
//                    else{
//                        x >>= i;
//                    }
//                }
//                result = count + !x;
                //improved for:
                /*
                x = decA, count = 0;
                for (unsigned int i = 16; i; i >>=1){
                    if (x >> i){
                        count += i;
                        x >>= i;
                    }
                }
                result = 32-count-x;
                 */
                cout << "Decimal: " << result << "\tHex: " << hex << result;
                cout << "\nZero: " << dec << (result == 0) << endl;
                break;
            case 12:
                x = decA;
                x |= x>>1;
                x |= x>>2;
                x |= x>>4;
                x |= x>>8;
                x |= x>>16;
                x++;
                x = (x*124511785) >> 27;
                result = debruijn32[x];
                if (decA == 0){
                    result = 32;
                }
//                x = ~decA, count = 0;
//                for (unsigned int i = 16; i; i >>= 1){
//                    if (x >> i){ x >>= i; } //use | reduction operator in verilog to reduct to 1 or 0
//                    else { count += i; }
//                }
//                result = count + !x;
                cout << "Decimal: " << dec << result << "\tHex: " << hex << result << "\nZero: ";
                zero = (result == 0);
                cout << dec << zero << endl;
            default:
                break;
        }
        }
        cout << "Would you like to continue (y/n)? ";
        cin >> cont;
    }

	return 0;
}
