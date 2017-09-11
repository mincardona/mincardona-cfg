/**
 * @author Michael Incardona
 */

#include "foo.hpp"

// default constructor
// should be provided, even if made private, for swap optimization
Foo::Foo()
: // member(nullptr)
{}

// member swap
friend void Foo::swap(Foo& first, Foo& second) noexcept {
    using std::swap;

    // swap(first->member, second->member);
}

// copy constructor
Foo::Foo(const Foo& other)
: // member(other->member)
{
    // member-by-member copy
}

// move constructor
Foo::Foo(Foo&& other)
: Foo()     // default construct this (C++11 onward)
{
    swap(*this, other);
}

// destructor
Foo::~Foo() noexcept {
    // if (this->member != nullptr) {
    //     delete this->member;
    // }
}

// copy assignment operator
// (copy elision makes a move asignment definition unnecessary)
Foo& Foo::operator=(Foo other)
: Foo()
{
    swap(*this, other);
    return *this;
}
