from deppkg.test cimport Test


cdef class SubTest(Test):
    cdef float y

    def __init__(self, y):
        super().__init__(y)
        self.y = float(self.x)
