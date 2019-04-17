package com.smart.web;

import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.smart.domain.ApprovalStatus;
import com.smart.domain.TakeOff;
import com.smart.pardomain.ParTakeOff;
import com.smart.statuscodeconstant.EveryApprovalCode;
import com.smart.statuscodeconstant.TakeOffStatusCode;
import com.smart.statuscodeconstant.TakeOffType;
import com.smart.statuscodeconstant.UserTypeCons;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.datetime.DateFormatter;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import com.smart.domain.User;
import com.smart.service.UserService;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
public class LoginController{

	private UserService userService;

	@InitBinder
	public void intDate(WebDataBinder dataBinder){
		dataBinder.addCustomFormatter(new DateFormatter("yyyy-MM-dd HH:mm"));
	}


	/*
	@RequestMapping(value = "/")
	public String root(){
		return "login";
	}

	@RequestMapping(value = "/index.html")
	public String loginPage(){
		return "login";
	}
	
	@RequestMapping(value = "/logincheck.html",method = RequestMethod.POST)
	public ModelAndView loginCheck(HttpServletRequest request,User commandUser){
		boolean isValidUser =  userService.hasMatchUser(commandUser.getUserName(),
					                    commandUser.getPassword());
		if (!isValidUser) {
			return new ModelAndView("login", "error", "用户名或密码错误。");
		} else {
			User user = userService.findUserByUserName(commandUser
					.getUserName());
			request.getSession().setAttribute("user", user);
			//System.out.println(user);

			return new ModelAndView("redirect:/main.html");
		}
	}
	*/
	@RequestMapping(value = "/login.html")
	public ModelAndView loginCheck(HttpServletRequest request){
			return new ModelAndView("login");
	}

	@RequestMapping(value = "/")
	public String root(){
		return "redirect:/main.html";
	}

	@RequestMapping(value = "/main.html")
	public ModelAndView main(HttpSession session){
		User user = (User)session.getAttribute("user");
		ModelAndView modelAndView = new ModelAndView("main");
		modelAndView.addObject("againstLostUser",user);
		modelAndView.addObject("takeOff",userService.findTakeOffByUserId(user.getUserId()));
		return modelAndView;
	}//这个方法是从上一个方法loginCheck中分出来

	/*
	@RequestMapping(value = "/logout")
	public String logout(HttpSession session){
		session.removeAttribute("user");
		return "redirect:index.html";
	}
	*/

	@RequestMapping(value = "/apply")
	public String takeOffForm(){
		return "applyForm";
	}

	@RequestMapping(value = "/message")
	public String message(){
		return "message";
	}

	@RequestMapping(value = "/apply/form/submit",method = RequestMethod.POST)
	public ModelAndView takeOffFormSubmit(TakeOff takeOff, final RedirectAttributes redirectAttributes){
		//System.out.println(takeOff);

		takeOff.setOffStatus(TakeOffStatusCode.Off_Prepared);//0
		userService.applyTakeOff(takeOff);
		//ModelAndView modelAndView = new ModelAndView("main");
		//modelAndView.addObject("formResult","提交成功");

		redirectAttributes.addFlashAttribute("formResult","提交成功");
		//return new ModelAndView("redirect:/main.html");
		return new ModelAndView("redirect:/message.html");
	}

	@RequestMapping(value = "/approvalsimple")//1
	public ModelAndView approvalSimple(HttpSession session){
		User user = (User)session.getAttribute("user");
		TakeOff takeOff = userService.findTakeOffByStatus(user.getUserType()-1);
		ModelAndView modelAndView = new ModelAndView("approval");
		if(takeOff != null) {
			commonMethod(takeOff, session, modelAndView);
		}else{
			modelAndView = new ModelAndView("message");
			modelAndView.addObject("formResult","已无待审批的请假单");
		}
		return modelAndView;
	}

	@RequestMapping(value = "/approval")//*
	public ModelAndView approval(HttpSession session,RedirectAttributes redirectAttributes){
		User user = (User)session.getAttribute("user");
		TakeOff takeOff = userService.findTakeOffByStatus(user.getUserType()-1);
		ModelAndView modelAndView = new ModelAndView("approvalMaster");
		if(takeOff != null) {
		}else{
			modelAndView = new ModelAndView("message");
			modelAndView.addObject("formResult","已无待审批的请假单");//这里能能不能处理得更好
			//modelAndView = new ModelAndView("redirect:/message.html");
			//redirectAttributes.addFlashAttribute("formResult","已无待审批的请假单");//这里一定要用flash属性吗
		}
		return modelAndView;
	}

	@RequestMapping(value = "/approval2")//*
	@ResponseBody
	public Map<String,Object> approval2(HttpSession session){
		User user = (User)session.getAttribute("user");
		ParTakeOff takeOff = userService.findTakeOffByStatus(user.getUserType()-1);
		return commonMethod3(takeOff);
	}

	private Map<String,Object> commonMethod3(ParTakeOff takeOff){
		Map<String,Object> map = new HashMap<>(16);
		map.put("code",0);
		map.put("message","");
		map.put("total",1000);
		if(takeOff != null) {
			commonMethod2(takeOff);
			List<ParTakeOff> list = new ArrayList<>(10);
			list.add(takeOff);
			map.put("data",list);
			System.out.println(map);
			return map;
		}else{
			map.put("data",new ArrayList<>(10));
			System.out.println(map);
			return map;
		}
	}

	private String translator(Integer code){
		if(code.equals(EveryApprovalCode.Accept)){
			return "同意";
		}
		if(code.equals(EveryApprovalCode.NotAccept)){
			return "驳回";
		}
		return null;
	}

	private void commonMethod2(ParTakeOff takeOff1){
		TakeOff takeOff = (TakeOff)takeOff1;
		User applyUser = userService.findUserById(takeOff.getUserId());
		takeOff1.setUserName(applyUser.getUserName());
		Integer firstUserId = takeOff.getFirstCheckUserId();
		User firstUser = null;
		if( firstUserId!= null) {
			firstUser = userService.findUserById(firstUserId);
			takeOff1.setFirstCheckUserName(firstUser.getUserName());
			takeOff1.setIsAcceptedByFirstChinese(translator(takeOff.getIsAcceptedByFirst()));
		}
		Integer secondUserId = takeOff.getSecondCheckUserId();
		User secondUser = null;
		if(secondUserId!=null) {
			secondUser = userService.findUserById(secondUserId);
			takeOff1.setSecondCheckUserName(secondUser.getUserName());
			takeOff1.setIsAcceptedBySecondChinese(translator(takeOff.getIsAcceptedBySecond()));
		}
		Integer thirdUserId = takeOff.getThirdCheckUserId();
		User thirdUser = null;
		if(thirdUserId!= null) {
			//System.out.println(thirdUserId);
			thirdUser = userService.findUserById(thirdUserId);
			takeOff1.setThirdCheckUserName(thirdUser.getUserName());
			takeOff1.setIsAcceptedByThirdChinese(translator(takeOff.getIsAcceptedByThird()));
		}
		if(takeOff.getOffType().equals(TakeOffType.Year_Off)){
			takeOff1.setOffTypeName("年假");
		}
		if(takeOff.getOffType().equals(TakeOffType.Thing_Off)){
			takeOff1.setOffTypeName("事假");
		}
		if(takeOff.getOffType().equals(TakeOffType.Sick_Off)){
			takeOff1.setOffTypeName("病假");
		}
	}

	@ResponseBody
	@RequestMapping(value = "/approval3")//*
	public Map<String,Object> approval3(Integer offId,Integer which){
		TakeOff takeOff = userService.findTakeOffById(offId);
		Map<String,Object> returnMap = new HashMap<>(16);
		if(which == 1){
			returnMap.put("opinion",takeOff.getFirstCheckUserOpinion());
		}else if(which == 2){
			returnMap.put("opinion",takeOff.getSecondCheckUserOpinion());
		}else if(which == 3){
			returnMap.put("opinion",takeOff.getThirdCheckUserOpinion());
		}else {
			returnMap.put("opinion",takeOff.getOffReason());
		}
		returnMap.put("status",1);
		return returnMap;
	}


	private void commonMethod(TakeOff takeOff,HttpSession session,ModelAndView modelAndView){
		User applyUser = userService.findUserById(takeOff.getUserId());
		Integer firstUserId = takeOff.getFirstCheckUserId();
		User firstUser = null;
		if( firstUserId!= null) {
			firstUser = userService.findUserById(firstUserId);
		}
		Integer secondUserId = takeOff.getSecondCheckUserId();
		User secondUser = null;
		if(secondUserId!=null) {
			secondUser = userService.findUserById(secondUserId);
		}
		Integer thirdUserId = takeOff.getThirdCheckUserId();
		User thirdUser = null;
		if(thirdUserId!= null) {
			//System.out.println(thirdUserId);
			thirdUser = userService.findUserById(thirdUserId);
		}
		modelAndView.addObject("takeOff",takeOff);
		modelAndView.addObject("applyUser",applyUser);
		modelAndView.addObject("firstUser",firstUser);
		modelAndView.addObject("secondUser",secondUser);
		modelAndView.addObject("thirdUser",thirdUser);

		modelAndView.addObject("againstLostFirstUser",firstUser);
		modelAndView.addObject("againstLostSecondUser",secondUser);
		modelAndView.addObject("againstLostThirdUser",thirdUser);

		//System.out.println(firstUser);
		//System.out.println(secondUser);
	}

	@RequestMapping(value = "/approval4")//*
	public ModelAndView approval4(Integer offId){
		ModelAndView modelAndView = new ModelAndView("approvalSlave");
		modelAndView.addObject("takeOff",userService.findTakeOffById(offId));
		return modelAndView;
		//这里是弹出页里又出现弹出页 把里弹出页关闭后 页面刷新 会从新请求外弹出页
	}
	@RequestMapping(value = "/approval/result",method = RequestMethod.POST)//* 1
	public String approvalResult(Integer offId, ApprovalStatus status,Integer checked,RedirectAttributes redirectAttributes){
		TakeOff takeOff = userService.findTakeOffById(offId);
		if(status.getUserType().equals(UserTypeCons.First_Check_User)){
			takeOff.setFirstCheckUserId(status.getCheckUserId());
			takeOff.setFirstCheckUserOpinion(status.getCheckUserOpinion());
			takeOff.setFirstCheckDatetime(new Date());//这里可能有问题
			takeOff.setIsAcceptedByFirst(checked);
			takeOff.setOffStatus(TakeOffStatusCode.Is_Accepted_By_First);
			if(checked.equals(EveryApprovalCode.First.NotAccept)){
				takeOff.setOffStatus(TakeOffStatusCode.Is_Not_Accepted);
			}
		}
		if(status.getUserType().equals(UserTypeCons.Second_Check_User)){
			takeOff.setSecondCheckUserId(status.getCheckUserId());
			takeOff.setSecondCheckUserOpinion(status.getCheckUserOpinion());
			takeOff.setSecondCheckDatetime(new Date());//这里可能有问题
			takeOff.setIsAcceptedBySecond(checked);
			takeOff.setOffStatus(TakeOffStatusCode.Is_Accepted_By_Second);
			if(checked.equals(EveryApprovalCode.Second.NotAccept)){
				takeOff.setOffStatus(TakeOffStatusCode.Is_Not_Accepted);
			}
		}
		if(status.getUserType().equals(UserTypeCons.Third_Check_User)){
			takeOff.setThirdCheckUserId(status.getCheckUserId());
			takeOff.setThirdCheckUserOpinion(status.getCheckUserOpinion());
			takeOff.setThirdCheckDatetime(new Date());//这里可能有问题
			takeOff.setIsAcceptedByThird(checked);
			takeOff.setOffStatus(TakeOffStatusCode.Is_Accepted_By_Third);
			if(checked.equals(EveryApprovalCode.Third.NotAccept)){
				takeOff.setOffStatus(TakeOffStatusCode.Is_Not_Accepted);
			}
		}
		userService.updateTakeOff(takeOff);
		//return "approvalSuccess";

		redirectAttributes.addFlashAttribute("formResult","审批成功");
		return "redirect:/message.html";
		//return "approvalSuccess";
	}

	//审批请假单和查看请假单 共用一个方法
	@RequestMapping(value = "/apply/viewsimple")// 1
	public ModelAndView viewApplySimple(HttpSession session){
		ModelAndView modelAndView = new ModelAndView("viewApply2");
		User user = (User)session.getAttribute("user");
		commonMethod(userService.findTakeOffByUserId(user.getUserId()),session,modelAndView);
		return modelAndView;
	}

	@RequestMapping(value = "/apply/view")//$
	public ModelAndView viewApply(HttpSession session){
		return new ModelAndView("viewApply");
	}


	@ResponseBody
	@RequestMapping(value = "/apply/view2")//$
	public Map<String,Object> viewApply2(HttpSession session){
		User user = (User)session.getAttribute("user");
		return commonMethod3(userService.findTakeOffByUserId(user.getUserId()));
	}

	@RequestMapping(value = "/apply/update")//&
	public ModelAndView updateApply(HttpSession session,@RequestParam(value = "mode",required = false) String mode){
		ModelAndView modelAndView = new ModelAndView("updateForm");
		if(mode!=null&&mode.equals("simple")){
			modelAndView.setViewName("updateForm2");
		}
		User user = (User)session.getAttribute("user");
		commonMethod(userService.findTakeOffByUserId(user.getUserId()),session,modelAndView);
		return modelAndView;
	}

	@RequestMapping(value = "/apply/update/submit",method = RequestMethod.POST)//&
	public ModelAndView updateApplyResult(TakeOff takeOff,RedirectAttributes redirectAttributes){
		//System.out.println(takeOff);
		userService.updateTakeOff(takeOff);

		//ModelAndView modelAndView = new ModelAndView("main");//这里可能有问题
		//modelAndView.addObject("formResult","修改成功");
		//modelAndView.addObject("takeOff",takeOff);

		redirectAttributes.addFlashAttribute("formResult","修改成功");
		//return new ModelAndView("redirect:/main.html");
		return new ModelAndView("redirect:/message.html");
	}

	//更新 请假单 和 更新被驳回的请假单 是调用查看请假单的方法
	@RequestMapping(value = "/apply/notaccepted/update")
	public ModelAndView updateNotAcceptedApply(HttpSession session,@RequestParam(value = "mode",required = false) String mode){
		ModelAndView modelAndView = updateApply(session,mode);
		modelAndView.addObject("changeUrl","/apply/notaccepted/update/submit");
		return modelAndView;
	}

	@RequestMapping(value = "/apply/notaccepted/update/submit",method = RequestMethod.POST)
	public ModelAndView updateNotAcceptedApplyResult(TakeOff takeOff,RedirectAttributes redirectAttributes){
		TakeOff newTakeOff = new TakeOff();
		newTakeOff.setOffStatus(TakeOffStatusCode.Off_Prepared);
		newTakeOff.setOffId(takeOff.getOffId());
		newTakeOff.setApplyDatetime(takeOff.getApplyDatetime());
		newTakeOff.setStartDate(takeOff.getStartDate());
		newTakeOff.setEndDate(takeOff.getEndDate());
		newTakeOff.setOffReason(takeOff.getOffReason());
		newTakeOff.setOffType(takeOff.getOffType());
		//System.out.println(takeOff.getUserId());
		newTakeOff.setUserId(takeOff.getUserId());

		//System.out.println(newTakeOff.getOffStatus());
		userService.updateTakeOffIfPropertyNull(takeOff);

		TakeOff newTakeOff2 = new TakeOff();
		newTakeOff2.setOffId(takeOff.getOffId());
		newTakeOff2.setOffStatus(TakeOffStatusCode.Off_Prepared);
		userService.updateTakeOff(newTakeOff2);

		//ModelAndView modelAndView = new ModelAndView("main");//这里可能有问题
		//modelAndView.addObject("formResult","修改成功");
		//modelAndView.addObject("takeOff",newTakeOff);

		redirectAttributes.addFlashAttribute("formResult","修改成功");
		//return new ModelAndView("redirect:/main.html");
		return new ModelAndView("redirect:/message.html");
	}


	@Autowired
	public void setUserService(UserService userService) {
		this.userService = userService;
	}
}
