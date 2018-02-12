package cmd;


public class cmd {
	 
    //��װһ�������������������з���ֵ�ķ�����
    static interface Function<TResult, TArg1, TArg2> {
        TResult process(TArg1 arg1, TArg2 arg2);
    }
 
    //ʵ��һЩ������ģ�⡰����ָ�롱
    public enum OpForInt implements Function<Integer, Integer, Integer> {
        //��
        Add(new Function<Integer, Integer, Integer>() {
            @Override
            public Integer process(Integer arg1, Integer arg2) {
                return arg1 + arg2;
            }
 
        }),
        //��
        Sub(new Function<Integer, Integer, Integer>() {
            @Override
            public Integer process(Integer arg1, Integer arg2) {
                return arg1 - arg2;
            }
 
        }),
        //��
        Mul(new Function<Integer, Integer, Integer>() {
            @Override
            public Integer process(Integer arg1, Integer arg2) {
                return arg1 * arg2;
            }
        }),
        //��
        Dev(new Function<Integer, Integer, Integer>() {
            @Override
            public Integer process(Integer arg1, Integer arg2) {
                return arg1 / arg2;
            }
        });
 
        //��װ����ʵ��
        Function<Integer, Integer, Integer> _delegate;
 
        //���ð�װ�ķ���ʵ��
        @Override
        public Integer process(Integer arg1, Integer arg2) {
            return _delegate.process(arg1, arg2);
        }
 
        private OpForInt(Function<Integer, Integer, Integer> delegate) {
            this._delegate = delegate;
        }
    }
 
    //������������������һ����������ָ��
    public static Integer process(Integer num1, Integer num2, OpForInt op) {
        return op.process(num1, num2);
    }
 
    public static void main(String[] args) {
        int num1 = 100;
        int num2 = 200;
        System.out.println(process(num1, num2, OpForInt.Add)); //��
        System.out.println(process(num1, num2, OpForInt.Sub)); //��
        System.out.println(process(num1, num2, OpForInt.Mul)); //��
        System.out.println(process(num1, num2, OpForInt.Dev)); //��
    }
}