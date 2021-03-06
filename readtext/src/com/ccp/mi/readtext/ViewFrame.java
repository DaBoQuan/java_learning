package com.ccp.mi.readtext;

import java.awt.*;
import java.awt.event.*;
import java.util.Date;
import java.util.TimerTask;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;

import javax.swing.*;

@SuppressWarnings("serial")
public class ViewFrame extends JFrame{
	//申明需要的组件
	private JButton jtf1 = null;
	private ScheduledExecutorService schedulePool = Executors.newSingleThreadScheduledExecutor();
	//private long delay = 0L;
	//private long intevalPeriod = 5*60*1000L;
	private CRUD dao = new CRUD();
	private int count = 1;
	private int count1 = 1;
	//可视化窗口	
	public ViewFrame() {
		setTitle("抓取PIMS抛出的APCValues");//设置窗口标题
		setSize(320, 360);//设置窗口大小
		setLocationRelativeTo(null);//设置窗口居中
		setDefaultCloseOperation(EXIT_ON_CLOSE);//设置关闭时退出虚拟机
		setLayout(new FlowLayout());//设置窗口布局为流式布局
		
		jtf1 = new JButton();
		jtf1.add(new JLabel("开始执行定时抓取任务"));
		add(new JLabel("点击将5分钟间歇自动抓取APCValues文本"));
		add(new JLabel("*********************************"));
		add(new JLabel("非特殊情况不要关闭此程序"));
		add(new JLabel("*********************************"));
		//add(new JLabel("若间歇期间文本没有更新，数据库不会插入重复数据"));
		add(jtf1);
			
		jtf1.addActionListener(new ActionListener() {//给按钮添加事件
			public void actionPerformed(ActionEvent e) {
				jtf1.setEnabled(false);
				scheduleTask();
			}
		});	
	}
	//间歇执行任务
	public void scheduleTask(){
		TimerTask task = new TimerTask() {
			@Override
			public void run() {
				try{
					System.out.println(new Date().toString()+"----start----------");
					boolean flag = dao.insert(dao.getQueryList());
					if(flag){
						System.out.println(new Date().toString()+"----第"+count+"次数据插入成功----");
						System.out.println();
						count++;
					}else{
						System.out.println(new Date().toString()+"----第"+count1+"次数据插入失败----！！！！！！！！！！！！！！！---------");
						System.out.println();
						count1++;
					}
				}catch(Exception e){
					System.out.println(new Date().toString()+"----run异常");
					e.printStackTrace();
				}
			}
		};
		schedulePool(task);
	}
	private void schedulePool(Runnable task){
		try {
			schedulePool.scheduleAtFixedRate(task, 0, 1000*60*5, TimeUnit.MILLISECONDS);
		} catch (Exception e) {
			e.printStackTrace();
			schedulePool(task);
		}
	}
}
