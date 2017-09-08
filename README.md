# ByteConvert
Target-independent tools for several byte conversions.

## About

ByteConvert can:
- Convert signed and unsigned integers to and from an array of 8-bit bytes.
- Change the endianess of signed and unsigned integers.
- Convert a single byte to and from an array of booleans.

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
        // prints 4128, (0x1020)
        trace( ByteConvert.toInt16([0x10, 0x20]) );
        
        // prints 270544960, (0x10203040)
        trace( ByteConvert.toUInt32([0x10, 0x20, 0x30, 0x40]) );
        
        // prints [170, 255], ([0xAA, 0xFF])
        trace( ByteConvert.fromInt16(43775) );
        
        //prints 4286045457, (0xFF77DD11)
        trace( ByteConvert.flipEndian32(0x11DD77FF) );
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
        // prints 4128, (0x1020)
        trace( [0x10, 0x20].toInt16() );
        
        // prints 270544960, (0x10203040)
        trace( [0x10, 0x20, 0x30, 0x40].toUInt32() );
        
        // prints [170, 255], ([0xAA, 0xFF])
        trace( 43775.fromInt16() );
        
        //prints 4286045457, (0xFF77DD11)
        trace( 0x11DD77FF.flipEndian32() );
    }
}
```
