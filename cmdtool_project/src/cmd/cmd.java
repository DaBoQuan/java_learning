package cmd;


public class cmd {
	 
    //包装一个“带有两个参数的有返回值的方法”
    static interface Function<TResult, TArg1, TArg2> {
        TResult process(TArg1 arg1, TArg2 arg2);
    }
 
    //实现一些方法，模拟“方法指针”
    public enum OpForInt implements Function<Integer, Integer, Integer> {
        //加
        Add(new Function<Integer, Integer, Integer>() {
            @Override
            public Integer process(Integer arg1, Integer arg2) {
                return arg1 + arg2;
            }
 
        }),
        //减
        Sub(new Function<Integer, Integer, Integer>() {
            @Override
            public Integer process(Integer arg1, Integer arg2) {
                return arg1 - arg2;
            }
 
        }),
        //乘
        Mul(new Function<Integer, Integer, Integer>() {
            @Override
            public Integer process(Integer arg1, Integer arg2) {
                return arg1 * arg2;
            }
        }),
        //除
        Dev(new Function<Integer, Integer, Integer>() {
            @Override
            public Integer process(Integer arg1, Integer arg2) {
                return arg1 / arg2;
            }
        });
 
        //包装方法实现
        Function<Integer, Integer, Integer> _delegate;
 
        //调用包装的方法实现
        @Override
        public Integer process(Integer arg1, Integer arg2) {
            return _delegate.process(arg1, arg2);
        }
 
        private OpForInt(Function<Integer, Integer, Integer> delegate) {
            this._delegate = delegate;
        }
    }
 
    //处理，两个操作数，一个操作方法指针
    public static Integer process(Integer num1, Integer num2, OpForInt op) {
        return op.process(num1, num2);
    }
 
    public static void main(String[] args) {
        int num1 = 100;
        int num2 = 200;
        System.out.println(process(num1, num2, OpForInt.Add)); //加
        System.out.println(process(num1, num2, OpForInt.Sub)); //减
        System.out.println(process(num1, num2, OpForInt.Mul)); //乘
        System.out.println(process(num1, num2, OpForInt.Dev)); //除
    }
}