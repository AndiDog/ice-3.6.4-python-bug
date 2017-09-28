#!/usr/local/bin/python2.7
import sys
import Ice
Ice.loadSlice('''
    --all
    Demo.ice
''')
import DemoModule

if __name__ == '__main__':
    ic = Ice.initialize(sys.argv)
    try:
        demo = DemoModule.DemoInterfacePrx.checkedCast(ic.stringToProxy('DemoObject:tcp -h 127.0.0.1 -p 12345'))
        demo.ice_ping()
        print(demo.method())
        print('DONE')
    finally:
        ic.destroy()
