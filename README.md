# ByteConvert
Target-independent tools for several byte conversions.

## About

ByteConvert can:

- Convert signed and unsigned integers to and from an array of 8-bit bytes.
- Change the endianess of signed and unsigned integers.
- Convert a single byte to and from an array of 1s and 0s.
- Read and write Ints and UInts from an array of bytes.
- Read and set specific bits of a number.

All features, except single-byte, work with 16-, 32-, and 64-bit lengths.

**64-bit operations aren't supported on 32-bit systems.**

## Installing

Install with: `haxelib install byteConvert`

Add `-lib byteConvert` to compilation flags.

## Importing

Import it with: `import byteConvert.ByteConvert`

Optional static extension with `using byteConvert.ByteConvert`

## Example
```
import byteConvert.ByteConvert;

class Example
{
    public static function main()
    {
        trace( ByteConvert.toInt16([0x10, 0x20]) ); // prints 4128, (0x1020)
        
        trace( ByteConvert.toUInt32([0x10, 0x20, 0x30, 0x40]) ); // prints 270544960, (0x10203040)
        
        trace( ByteConvert.readUInt16([0x10, 0x20, 0x30, 0x40], 1) ); // prints 8240, (0x2030)
        
        trace( ByteConvert.fromInt16(43775) ); // prints [170, 255], ([0xAA, 0xFF])
        
        trace( ByteConvert.flipEndian32(0x11DD77FF) ); //prints 4286045457, (0xFF77DD11)
        
        var ar:Array<Int> = [0x10, 0x20, 0x30, 0x40];
        trace(readInt16(ar, 2)); // prints 12352 (0x3040)
        
        ByteConvert.writeInt16(ar, 1, 0xaaff);
        trace(ar); //prints 279641920, (10aaff40)
        
        trace(byteConvert.bit(0x04, 2)); // prints 1
        trace(byteConvert.bits(0x04, 1, 3)); // prints 2 
        
        trace(byteConvert.bit(0x04, 0, 1)); // prints 5
        trace(byteConvert.bits(0x04, 1, 3, 5)); // prints 14 
    }
}
```

As static extension
```
import byteConvert.ByteConvert;

using byteConvert.ByteConvert;

class Example
{
    public static function main()
    {
        trace( [0x10, 0x20].toInt16() ); // prints 4128, (0x1020)
        
        trace( [0x10, 0x20, 0x30, 0x40].toUInt32() ); // prints 270544960, (0x10203040)
        
        trace( [0x10, 0x20, 0x30, 0x40].readUInt16(1) ); // prints 8240, (0x2030)
        
        trace( 43775.fromInt16() ); // prints [170, 255], ([0xAA, 0xFF])
        
        trace( 0x11DD77FF.flipEndian32() ); //prints 4286045457, (0xFF77DD11)
        
        var ar:Array<Int> = [0x10, 0x20, 0x30, 0x40];
        trace(ar.readInt16(2)); // prints 12352 (0x3040)
        
        ar.writeInt16(1, 0xaaff);
        trace(ar); //prints 279641920, (10aaff40)
        
        trace(0x04.bit(2)); // prints 1
        trace(0x04.bits(1, 3)); // prints 2 
        
        trace(0x04.bit(0, 1)); // prints 5
        trace(0x04.bits(1, 3, 5)); // prints 14 
    }
}
```
