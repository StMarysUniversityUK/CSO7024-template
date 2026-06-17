"""Unit tests for the calculator module.

These tests are what the Week 3 continuous integration pipeline runs on every
push. They are intentionally small but real: they pass when the code is correct
and fail when it is not, which is exactly what you need to see a pipeline go
green and red.
"""

import pytest

from calculator import add, subtract, multiply, divide


def test_add():
    assert add(2, 3) == 5
    assert add(-1, 1) == 0


def test_subtract():
    assert subtract(5, 3) == 2
    assert subtract(0, 4) == -4


def test_multiply():
    assert multiply(4, 3) == 12
    assert multiply(-2, 5) == -10


def test_divide():
    assert divide(10, 2) == 5
    assert divide(9, 3) == 3


def test_divide_by_zero_raises():
    with pytest.raises(ZeroDivisionError):
        divide(1, 0)
