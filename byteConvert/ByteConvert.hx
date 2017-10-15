package byteConvert;

/**
    Target independent tools for several byte conversions.
    
    All values are manipulated as Int and UInt.
    
    64-bit functions don't work on 32-bit systems.
**/

class ByteConvert
{
    /**
        Returns an array of 0s and 1s representing an 32- or 64-bit UInt,
        with the first element being the least significant bit.
    **/
    public static function toBits(num:UInt):Array<Int>
    {
        var ar:Array<Int> = [];
        var length:Int = 32;
        
        // if bigger, it's 64-bit number
        length = (num > 0xFFFFFFFF)? 64: 32;
        
        for (i in 0...length)
        {
            ar.push( (num & (1 << i)) >> i );
        }
        
        return ar;
    }
    
    /**
        Returns an 32- or 64-bit UInt from the given array of 0s and 1s,
        with the first element being the least significant bit.
    **/
    public static function fromBits(num:Array<Int>):UInt
    {
        var n:UInt = 0;
        
        for (i in 0...num.length)
        {
            n += (num[i] != 0)? 1 << i: 0;
        }
        
        return n;
    }
    
    /**
        Returns num with pos bit set to val.
        
        Pos starts at cero from the least significant bit.
        
        If val isn't set, returns the value of bit at pos.
    **/
    public static function bit(num:UInt, pos:Int, ?val:Int):Int
    {
        var ar = toBits(num);
        
        if (val >= 0)
        {
            ar[pos] = val;
            return fromBits(ar);
        }
        
        return ar[pos];
    }
    
    /**
        Returns num with len bits of val set at pos.
        
        Pos starts at cero from the least significant bit.
        
        If val isn't set, returns len bits at pos.
    **/
    public static function bits(num:UInt, pos:Int, len:Int, ?val:UInt):UInt
    {
        var newNum:UInt = (val >= 0)? num: 0;
        
        for (i in 0...len)
        {
            if (val >= 0)
            {
                newNum = bit(newNum, pos+i, bit(val, i));
            }
            else
            {
                newNum = bit(newNum, i, bit(num, pos+i));
            }
        }
        
        return newNum;
    }
    
    /**
        Changes the endianess of a 16-bit value.
    **/
    public static function flipEndian16(int:UInt):UInt
    {
        // truncate upper 16-bit
        if (int > 0xFFFF)
        {
            int = int & 0xFFFF;
        }
        
        var num:UInt = 0;
        
        for (i in 0...2)
        {
            // shift left to remove higher numbers,
            // shift right to remvove lower numbers,
            // shift left to new position.
            num += (((int << (i * 8)) & 0xFFFF) >> 8) << (i * 8);
        }
        
        return num;
    }
    
    /**
        Changes the endianess of a 32-bit value.
    **/
    public static function flipEndian32(int:UInt):UInt
    {
        // truncate upper 32-bit
        if (int > 0xFFFFFFFF)
        {
            int = int & 0xFFFFFFFF;
        }
        
        var num:UInt = 0;
        
        for (i in 0...4)
        {
            // shift left to remove higher numbers,
            // shift right to remvove lower numbers,
            // shift left to new position.
            num += (((int << (i * 8)) & 0xFFFFFFFF) >> 24) << (i * 8);
        }
        
        return num;
    }
    
    /**
        Changes the endianess of a 64-bit value..
    **/
    public static function flipEndian64(int:UInt):UInt
    {
        var num:UInt = 0;
        
        for (i in 0...8)
        {
            num += ((int << (i * 8)) >> 56) << (i * 8);
        }
        
        return num;
    }
    
    /**
       Return a 16-bit signed integer from b bytes array.
    **/
    public static function toInt16(b:Array<Int>):Int
    {
        var int:Int = 0;
        
        for (i in 0...2)
        {
            int = (int << 8) | b[i];
        }
        
        return int;
    }
    
    /**
       Return a 32-bit signed integer from b bytes array.
    **/
    public static function toInt32(b:Array<Int>):Int
    {
        var int:Int = 0;
        
        for (i in 0...4)
        {
            int = (int << 8) | b[i];
        }
        
        return int;
    }
    
    /**
       Return a 64-bit signed integer from b bytes array.
    **/
    public static function toInt64(b:Array<Int>):Int
    {
        var int:Int = 0;
        
        for (i in 0...8)
        {
            int = (int << 8) | b[i];
        }
        
        return int;
    }
    
    /**
       Return a 16-bit unsigned integer from b bytes array.
    **/
    public static function toUInt16(b:Array<Int>):UInt
    {
        var uint:UInt = 0;
        
        for (i in 0...2)
        {
            uint = (uint << 8) | b[i];
        }
        
        return uint;
    }
    
    /**
       Return a 32-bit unsigned integer from b bytes array.
       
       @param b 4-byte array with the first element being the most significant byte.
    **/
    public static function toUInt32(b:Array<Int>):UInt
    {
        var uint:UInt = 0;
        
        for (i in 0...4)
        {
            uint = (uint << 8) | b[i];
        }
        
        return uint;
    }
    
    /**
       Return a 64-bit unsigned integer from b bytes array.
       
       **Doesn't work in 32-bit systems.**
    **/
    public static function toUInt64(b:Array<Int>):UInt
    {
        var uint:UInt = 0;
        
        for (i in 0...8)
        {
            uint = (uint << 8) | b[i];
        }
        
        return uint;
    }
    
    /**
        Returns the given 16-bit Int as array of Bytes.
    **/
    public static function fromInt16(n:Int):Array<Int>
    {
        var ar:Array<Int> =[];
        
        ar.push((n & 0xFF00) >> 8);
        ar.push(n & 0x00FF);
        
        return ar;
    }
    
    /**
        Returns the given 32-bit Int as array of Bytes.
    **/
    public static function fromInt32(n:Int):Array<Int>
    {
        var ar:Array<Int> =[];
        
        for (i in 0...4)
        {
            ar.push((n << (i * 8)) >> 24);
        }
        
        return ar;
    }
    
    /**
        Returns the given 64-bit Int as array of Bytes.
    **/
    public static function fromInt64(n:UInt):Array<Int>
    {
        var ar:Array<Int> =[];
        
        for (i in 0...8)
        {
            ar.push((n << (i * 8)) >> 56);
        }
        
        return ar;
    }
    
    /**
        Returns the given 16-bit UInt as an array of Bytes.
    **/
    public static function fromUInt16(n:UInt):Array<Int>
    {
        var ar:Array<Int> =[];
        
        ar.push((n & 0xFF00) >> 8);
        ar.push(n & 0x00FF);
        
        return ar;
    }
    
    /**
        Returns the given 32-bit UInt as array of Bytes.
    **/
    public static function fromUInt32(n:UInt):Array<Int>
    {
        var ar:Array<Int> =[];
        
        for (i in 0...4)
        {
            ar.push((n << (i * 8)) >> 24);
        }
        
        return ar;
    }
    
    /**
        Returns the given 64-bit UInt as array of Bytes.
    **/
    public static function fromUInt64(n:UInt):Array<Int>
    {
        var ar:Array<Int> =[];
        
        for (i in 0...8)
        {
            ar.push((n << (i * 8)) >> 56);
        }
        
        return ar;
    }
    
    /**
       Return a 16-bit signed integer from b bytes array at pos index.
    **/
    public static function readInt16(b:Array<Int>, pos:Int):Int
    {
        return toInt16(b.slice(pos, pos+2));
    }
    
    /**
       Return a 32-bit signed integer from b bytes array at pos index.
    **/
    public static function readInt32(b:Array<Int>, pos:Int):Int
    {
        return toInt32(b.slice(pos, pos+4));
    }
    
    /**
       Return a 64-bit signed integer from b bytes array at pos index.
    **/
    public static function readInt64(b:Array<Int>, pos:Int):Int
    {
        return toInt64(b.slice(pos, pos+8));
    }
    
    /**
       Return a 16-bit unsigned integer from b bytes array at pos index.
    **/
    public static function readUInt16(b:Array<Int>, pos:Int):UInt
    {
        return toUInt16(b.slice(pos, pos+2));
    }
    
    /**
       Return a 32-bit unsigned integer from b bytes array at pos index.
    **/
    public static function readUInt32(b:Array<Int>, pos:Int):UInt
    {
        return toUInt32(b.slice(pos, pos+4));
    }
    
    /**
       Return a 64-bit unsigned integer from b bytes array at pos index.
    **/
    public static function readUInt64(b:Array<Int>, pos:Int):UInt
    {
        return toUInt64(b.slice(pos, pos+8));
    }
         
    /**
        Write a 16-bit signed integer in b bytes array at pos index.
    **/
    public static function writeInt16(b:Array<Int>, pos:Int, num:Int):Void
    {
        var ar:Array<Int> = fromInt16(num);

        for (i in 0...2)
        {
            b[pos+i] = ar[i];
        }
    }
    
    /**
        Write a 32-bit signed integer in b bytes array at pos index.
    **/
    public static function writeInt32(b:Array<Int>, pos:Int, num:Int):Void
    {
        var ar:Array<Int> = fromInt32(num);

        for (i in 0...4)
        {
            b[pos+i] = ar[i];
        }
    }
    
    /**
        Write a 64-bit signed integer in b bytes array at pos index.
    **/
    public static function writeInt64(b:Array<Int>, pos:Int, num:Int):Void
    {
        var ar:Array<Int> = fromInt64(num);

        for (i in 0...8)
        {
            b[pos+i] = ar[i];
        }
    }
        
    /**
        Write a 16-bit unsigned integer in b bytes array at pos index.
    **/
    public static function writeUInt16(b:Array<Int>, pos:Int, num:UInt):Void
    {
        var ar:Array<Int> = fromUInt16(num);

        for (i in 0...2)
        {
            b[pos+i] = ar[i];
        }
    }
    
    /**
        Write a 32-bit unsigned integer in b bytes array at pos index.
    **/
    public static function writeUInt32(b:Array<Int>, pos:Int, num:UInt):Void
    {
        var ar:Array<Int> = fromUInt32(num);

        for (i in 0...4)
        {
            b[pos+i] = ar[i];
        }
    }
    
    /**
        Write a 64-bit unsigned integer in b bytes array at pos index.
    **/
    public static function writeUInt64(b:Array<Int>, pos:Int, num:UInt):Void
    {
        var ar:Array<Int> = fromUInt64(num);

        for (i in 0...8)
        {
            b[pos+i] = ar[i];
        }
    }
}
