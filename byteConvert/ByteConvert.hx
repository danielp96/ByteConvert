package byteConvert;

/**
    Target independent tools for several byte conversions.
    
    All values are manipulated as Int and UInt.
**/

class ByteConvert
{
    /**
        Returns an array of 0s and 1s representing an 8-bit Int,
        with the first element being the least significant bit.
        
        @param byte value to be converted.
    **/
    public static function toBits(byte:Int):Array<Int>
    {
        var ar:Array<Int> = [];
        
        ar.push( ((byte & 0x01) == 0)? 0: 1 );
        ar.push( ((byte & 0x02) == 0)? 0: 1 );
        ar.push( ((byte & 0x04) == 0)? 0: 1 );
        ar.push( ((byte & 0x08) == 0)? 0: 1 );
        ar.push( ((byte & 0x10) == 0)? 0: 1 );
        ar.push( ((byte & 0x20) == 0)? 0: 1 );
        ar.push( ((byte & 0x40) == 0)? 0: 1 );
        ar.push( ((byte & 0x80) == 0)? 0: 1 );
        
        return ar;
    }
    
    /**
        Returns an 8-bit Int from the given array of 0s and 1s,
        with the first element being the least significant bit.
        
        @param num int array representing a byte.
    **/
    public static function fromBits(num:Array<Int>):Int
    {
        var n:Int = 0;
        
        // iterate in reverse to keep bit order
        for (i in 0...8)
        {
            n += (num[i] != 0)? 1 << i: 0;
        }
        
        return n;
    }
    
    /**
        Returns num with pos bit set to val.
        
        @param num 8-bit Int to read/edit.
        @param pos right-to-left 0-7 bit position.
        @param val value to set the bit to.
        
        If val is null it returns the value of bit at pos.
    **/
    public static function bit(num:Int, pos:Int, ?val:Int):Int
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
        Changes the endianess of a 16-bit value.
        @param int value to be flipped.
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
        @param int value to be flipped.
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
        Changes the endianess of a 64-bit value.
        
        **Doesn't work in 32-bit systems**
        
        @param int value to be flipped.
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
       Return a 16-bit signed integer from the given bytes array.
       
       @param b 2-byte array with the first element being the most significant byte.
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
       Return a 32-bit signed integer from the given bytes array.
       
       @param b 4-byte array with the first element being the most significant byte.
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
       Return a 64-bit signed integer from the given bytes array.
       
       **Doesn't work in 32-bit systems**
       
       @param b 8-byte array with the first element being the most significant byte.
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
       Return a 16-bit unsigned integer from the given bytes array.
       
       @param b 2-byte array with the first element being the most significant byte.
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
       Return a 32-bit unsigned integer from the given bytes array.
       
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
       Return a 64-bit unsigned integer from the given bytes array.
       
       **Doesn't work in 32-bit systems.**
       
       @param b 8-byte array with the first element being the most significant byte.
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
        Returns the given 16-bit Int as an array of Bytes,
        with the first element being the most significant byte.
        
        @param n value to be converted.
    **/
    public static function fromInt16(n:Int):Array<Int>
    {
        var ar:Array<Int> =[];
        
        ar.push((n & 0xFF00) >> 8);
        ar.push(n & 0x00FF);
        
        return ar;
    }
    
    /**
        Returns the given 32-bit Int as an array of Bytes,
        with the first element being the most significant byte.
        
        @param n value to be converted.
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
        Returns the given 64-bit Int as an array of Bytes,
        with the first element being the most significant byte.
        
        **Doesn't work in 32-bit systems**
        
        @param n value to be converted.
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
        Returns the given 16-bit UInt as an array of Bytes,
        with the first element being the most significant byte.
        
        @param n value to be converted.
    **/
    public static function fromUInt16(n:UInt):Array<Int>
    {
        var ar:Array<Int> =[];
        
        ar.push((n & 0xFF00) >> 8);
        ar.push(n & 0x00FF);
        
        return ar;
    }
    
    /**
        Returns the given 32-bit UInt as an array of Bytes,
        with the first element being the most significant byte.
        
        @param n value to be converted.
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
        Returns the given 64-bit UInt as an array of Bytes,
        with the first element being the most significant byte.
        
        **Doesn't work in 32-bit systems**
        
        @param n value to be converted.
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
       Return a 16-bit signed integer from the given bytes array at the given position.
       
       @param b byte array.
       @param pos position to read from.
    **/
    public static function readInt16(b:Array<Int>, pos:Int):Int
    {
        return toInt16(b.slice(pos, pos+2));
    }
    
    /**
       Return a 32-bit signed integer from the given bytes array at the given position.
       
       @param b byte array.
       @param pos position to read from.
    **/
    public static function readInt32(b:Array<Int>, pos:Int):Int
    {
        return toInt32(b.slice(pos, pos+4));
    }
    
    /**
       Return a 64-bit signed integer from the given bytes array at the given position.
        
        **Doesn't work in 32-bit systems**
       
       @param b byte array.
       @param pos position to read from.
    **/
    public static function readInt64(b:Array<Int>, pos:Int):Int
    {
        return toInt64(b.slice(pos, pos+8));
    }
    
    /**
       Return a 16-bit unsigned integer from the given bytes array at the given position.
       
       @param b byte array.
       @param pos position to read from.
    **/
    public static function readUInt16(b:Array<Int>, pos:Int):UInt
    {
        return toUInt16(b.slice(pos, pos+2));
    }
    
    /**
       Return a 32-bit unsigned integer from the given bytes array at the given position.
       
       @param b byte array.
       @param pos position to read from.
    **/
    public static function readUInt32(b:Array<Int>, pos:Int):UInt
    {
        return toUInt32(b.slice(pos, pos+4));
    }
    
    /**
       Return a 64-bit unsigned integer from the given bytes array at the given position.
        
        **Doesn't work in 32-bit systems**
       
       @param b byte array.
       @param pos position to read from.
    **/
    public static function readUInt64(b:Array<Int>, pos:Int):UInt
    {
        return toUInt64(b.slice(pos, pos+8));
    }
         
    /**
        Write a 16-bit signed integer in the given bytes array at the given position.
        
        @param b byte array.
        @param pos position to write at.
        @param num number to write.
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
        Write a 32-bit signed integer in the given bytes array at the given position.
        
        @param b byte array.
        @param pos position to write at.
        @param num number to write.
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
        Write a 64-bit signed integer in the given bytes array at the given position.
        
        @param b byte array.
        @param pos position to write at.
        @param num number to write.
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
        Write a 16-bit unsigned integer in the given bytes array at the given position.
        
        @param b byte array.
        @param pos position to write at.
        @param num number to write.
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
        Write a 32-bit unsigned integer in the given bytes array at the given position.
        
        @param b byte array.
        @param pos position to write at.
        @param num number to write.
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
        Write a 64-bit unsigned integer in the given bytes array at the given position.
         
         **Doesn't work in 32-bit systems**
        
        @param b byte array.
        @param pos position to write at.
        @param num number to write.
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
