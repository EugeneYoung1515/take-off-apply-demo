package com.smart.web;

import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.smart.domain.ApprovalStatus;
import com.smart.domain.TakeOff;
import com.smart.statuscodeconstant.EveryApprovalCode;
import com.smart.statuscodeconstant.TakeOffStatusCode;
import com.smart.statuscodeconstant.UserTypeCons;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.datetime.DateFormatter;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.smart.domain.User;
import com.smart.service.UserService;

@RestController
public class LoginController{

	private UserService userService;

	@InitBinder
	public void intDate(WebDataBinder dataBinder){
		dataBinder.addCustomFormatter(new DateFormatter("yyyy-MM-dd HH:mm"));
	}

	@RequestMapping(value = "/index.html")
	public String loginPage(){
		return "login";
	}
	
	@RequestMapping(value = "/logincheck.html")
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
			ModelAndView modelAndView = new ModelAndView("main");
			modelAndView.addObject("againstLostUser",user);
			modelAndView.addObject("takeOff",userService.findTakeOffByUserId(user.getUserId()));
			return modelAndView;
		}
	}

	@RequestMapping(value = "/logout")
	public String logout(HttpSession session){
		session.removeAttribute("user");
		return "redirect:index.html";
	}

	@RequestMapping(value = "/apply")
	public String takeOffForm(){
		return "applyForm";
	}

	@RequestMapping(value = "/apply/form/submit")
	public ModelAndView takeOffFormSubmit(TakeOff takeOff){
		//System.out.println(takeOff);

		takeOff.setOffStatus(TakeOffStatusCode.Off_Prepared);//0
		userService.applyTakeOff(takeOff);
		ModelAndView modelAndView = new ModelAndView("main");
		modelAndView.addObject("formResult","提交成功");
		modelAndView.addObject("takeOff",takeOff);//之前没有这一句好像在jsp中显示takeOff
		return modelAndView;
	}

	@RequestMapping(value = "/approval")
	public ModelAndView approval(HttpSession session){
		User user = (User)session.getAttribute("user");
		TakeOff takeOff = userService.findTakeOffByStatus(user.getUserType()-1);
		ModelAndView modelAndView = new ModelAndView("approval");
		if(takeOff != null) {
			commonMethod(takeOff, session, modelAndView);
		}else{
			modelAndView = new ModelAndView("main");
			modelAndView.addObject("formResult","已无待审批的请假单");
		}
		return modelAndView;
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

	@RequestMapping(value = "approval/result")
	public String approvalResult(Integer offId, ApprovalStatus status,Integer checked){
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
		return "approvalSuccess";
	}

	//审批请假单和查看请假单 共用一个方法
	@RequestMapping(value = "apply/view")
	public ModelAndView viewApply(HttpSession session){
		ModelAndView modelAndView = new ModelAndView("viewApply");
		User user = (User)session.getAttribute("user");
		commonMethod(userService.findTakeOffByUserId(user.getUserId()),session,modelAndView);
		return modelAndView;
	}

	@RequestMapping(value = "apply/update")
	public ModelAndView updateApply(HttpSession session){
		ModelAndView modelAndView = viewApply(session);
		modelAndView.setViewName("updateForm");
		return modelAndView;
	}

	@RequestMapping(value = "apply/update/submit")
	public ModelAndView updateApplyResult(TakeOff takeOff){
		//System.out.println(takeOff);
		userService.updateTakeOff(takeOff);
		ModelAndView modelAndView = new ModelAndView("main");//这里可能有问题
		modelAndView.addObject("formResult","修改成功");
		modelAndView.addObject("takeOff",takeOff);
		return modelAndView;
	}

	//更新 请假单 和 更新被驳回的请假单 是调用查看请假单的方法
	@RequestMapping(value = "apply/notaccepted/update")
	public ModelAndView updateNotAcceptedApply(HttpSession session){
		ModelAndView modelAndView = updateApply(session);
		modelAndView.addObject("changeUrl","/offcheck/apply/notaccepted/update/submit");
		return modelAndView;
	}

	@RequestMapping(value = "apply/notaccepted/update/submit")
	public ModelAndView updateNotAcceptedApplyResult(TakeOff takeOff){
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
		ModelAndView modelAndView = new ModelAndView("main");//这里可能有问题
		modelAndView.addObject("formResult","修改成功");
		modelAndView.addObject("takeOff",newTakeOff);
		return modelAndView;
	}


	@Autowired
	public void setUserService(UserService userService) {
		this.userService = userService;
	}
}
