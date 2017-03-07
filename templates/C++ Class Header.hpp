/**
 * @author Michael Incardona
 */
#ifndef FOO_HPP
#define FOO_HPP

public class Foo {
public:
    // constructor
    Foo();
    
    // member swap
    friend void swap(Foo& first, Foo& second) noexcept;
    
    // copy constructor
    Foo(const Foo& other);
    
    // move constructor
    Foo(Foo&& other);
    
    // destructor
    virtual ~Foo() noexcept;
    
    // copy assignment operator
    // (copy elision makes a move asignment definition unnecessary)
    Foo& operator=(Foo other);
};

#endif

