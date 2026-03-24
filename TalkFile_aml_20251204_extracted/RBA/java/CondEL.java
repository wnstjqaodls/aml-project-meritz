package com.gtone.aml.basic.jspeed.base.el;

import javax.servlet.jsp.PageContext;

import com.gtone.aml.basic.common.data.DataObj;
import com.gtone.aml.basic.common.log.Log;
import com.gtone.aml.dao.common.MDaoUtilSingle;
import com.gtone.aml.server.common.commonUtil;

import jspeed.base.property.PropertyService;
import jspeed.base.util.StringHelper;
import jspeed.base.xml.XMLHelper;
import net.sf.json.JSONArray;
import net.sf.json.JSONException;
import net.sf.json.JSONObject;

public class CondEL
  extends AbsEL
{
  public CondEL() {}

  public CondEL(PageContext pageContext)
  {
    super(pageContext);
  }

  public String getProductSearch(String name, String firstComboWord)
  {
    return getProductSearch(name, firstComboWord, "", "", false);
  }

  public String getProductSearch(String name, String firstComboWord, String initValue, String allSelectCombo, boolean isHidden)
  {
    String html = "";
    if ((this.sessionAML != null) && (this.request != null))
    {
      String fcw = getHelperMsg(firstComboWord, firstComboWord, new String[0]);

      String prodMaxLength = PropertyService.getInstance().getProperty("aml.config", "prodMaxLength");
      html = html + "<input type='text' id='" + name + "' name='" + name + "' size='" + (Integer.parseInt(prodMaxLength) + 1) + "' ";
      if ((prodMaxLength != null) && (!"".equals(prodMaxLength))) {
        html = html + "maxlength='" + prodMaxLength + "' ";
      }
      html = html + " style='text-align:center;' onblur='setScName()' onclick='this.select();'";



      html = html + "/>";

      html = html + "<span class='cond-branch-btn' onclick='popupProductWindow(\"prod_list\",\"" + name + "\",\"" + name + "_NM\")'>";
      html = html + "<i id='IconBranch' class='fa fa-search' ></i>";
      html = html + "</span>";
      if (!isHidden) {
        html = html + "<input type='text' id='" + name + "_NM' name='" + name + "_NM' size='15' readonly='readonly' />";
      } else {
        html = html + " <input type='hidden' id='" + name + "_NM' name='" + name + "_NM'/>";
      }
      html = html + "<select id='prod_list' name='prod_list' style='display:none'>";
      html = html + commonUtil.setComboHtmlProduct(this.sessionAML, initValue, fcw);
      html = html + " </select> ";
      html = html + " <script>initProductWindow('prod_list','" + name + "','" + name + "_NM');searchSc('init');winProduct.hide();</script> ";
    }
    return html;
  }

  public String getBranchSearch(String config)
  {
    if ((config != null) && (!"".equals(config.trim())))
    {
      JSONObject json = toJSONObject(config);
      String msgID = json.optString("msgID");
      String defaultValue = json.optString("defaultValue");
      if (!"".equals(msgID)) {
        return getBranchSearch(
          msgID,
          defaultValue,
          json.optString("name"),
          json.optString("firstComboWord"),
          json.optString("initValue"),
          json.optString("allSelectCombo"),
          "true".equals(json.optString("isHidden")));
      }
      return getBranchSearch(
        json.optString("name"),
        json.optString("firstComboWord"),
        json.optString("initValue"),
        json.optString("allSelectCombo"),
        "true".equals(json.optString("isHidden")));
    }
    return "<script>alert('"+getHelperMsg("msg_common_00_000", "CondEL.getBranchSearch 의 컨피그레이션 값이 올바르지 않습니다.", new String[0])+"');</script>";
  }

  public String getBranchSearchJspf(String config)
  {
    if ((config != null) && (!"".equals(config.trim())))
    {
      JSONObject json = toJSONObject(config);

      return getBranchSearchJspf(
        json.optString("name"),
        json.optString("firstComboWord"),
        json.optString("initValue"),
        json.optString("allSelectCombo"),
        "true".equals(json.optString("isHidden")));
    }
    return "<script>alert('"+getHelperMsg("msg_common_00_000", "CondEL.getBranchSearch 의 컨피그레이션 값이 올바르지 않습니다.", new String[0])+"');</script>";
  }

  public String getBranchSearch(String msgID, String defaultValue, String name, String firstComboWord, String initValue, String allSelectCombo, boolean isHidden)
  {
    return getLabel(msgID, defaultValue) + getBranchSearch(name, firstComboWord, initValue, allSelectCombo, isHidden);
  }

  public String getBranchSearch(String name, String firstComboWord)
  {

    return getBranchSearch(name, firstComboWord, "", "", false);
  }

  public String getBranchSearch(String name, String firstComboWord, String initValue, String allSelectCombo, boolean isHidden)
  {
    String html = "";
    if ((this.sessionAML != null) && (this.request != null))
    {
      String fcw = getHelperMsg(firstComboWord, firstComboWord, new String[0]);
      String comboWord = fcw;

      String masterBranch = this.sessionAML.getsAML_MASTER_BRANCH();
      fcw = "Y".equals(masterBranch) ? fcw : "";
      if ("".equals(fcw)) {
        fcw = (allSelectCombo != null) && ("Y".equals(allSelectCombo)) ? comboWord : "";
      }
      String branchMaxLength = PropertyService.getInstance().getProperty("aml.config", "branchMaxLength");

      html = html + "<div class='content search'>";
      html = html + "<input type='text' id='" + name + "' name='" + name + "' size='" + (Integer.parseInt(branchMaxLength) + 1) + "' readonly='readonly' class='search-input' ";
      if ((branchMaxLength != null) && (!"".equals(branchMaxLength))) {
        html = html + "maxlength='" + branchMaxLength + "' ";
      }
      html = html + " style='text-align:center;width:100px;' onblur='setScName()' onclick='this.select();' onkeydown='eventEnterKeyBranch();' ";

      if (!"Y".equals(masterBranch)) {
        html = html + "readonly='readonly'";
      }
      html = html + "/>";



      if (("N").equals(masterBranch)) {
    	  html = html + "<button type='button' class='btn-36'>";
      } else {
    	  html = html + "<button type='button' class='btn-36' onclick='popupBranchWindow(\"brn_list\",\"" + name + "\",\"" + name + "_NM\")'>";
      }

      html = html + getHelperMsg("AML_90_01_01_01_btn_01", "검색", new String[0]) + "</button>";
      if (!isHidden) {
        html = html + "<input type='text' id='" + name + "_NM' name='" + name + "_NM' size='15'  readonly='readonly' />";
      } else {
        html = html + " <input type='hidden' id='" + name + "_NM' name='" + name + "_NM'/>";
      }
      html = html + "<select id='brn_list' name='brn_list' style='display:none' class='dropdown'>";
      if (((initValue == null) || ("".equals(initValue))) && ("N".equals(masterBranch))) {
        initValue = this.sessionAML.getsAML_BDPT_CD();
      }
      html = html + commonUtil.setComboHtmlBranch(this.sessionAML, initValue, fcw);
      html = html + " </select> ";
      html = html + " <script>initBranchWindow('brn_list','" + name + "','" + name + "_NM');searchSc('init');winBranch.hide();</script> ";
    }
    html = html + "</div>";
    return html;
  }

  public String getBranchSearchJspf(String name, String firstComboWord, String initValue, String allSelectCombo, boolean isHidden)
  {
    String html = "";
    if ((this.sessionAML != null) && (this.request != null))
    {
      String fcw = getHelperMsg(firstComboWord, firstComboWord, new String[0]);
      String comboWord = fcw;

      String masterBranch = this.sessionAML.getsAML_MASTER_BRANCH();
      fcw = "Y".equals(masterBranch) ? fcw : "";
      if ("".equals(fcw)) {
        fcw = (allSelectCombo != null) && ("Y".equals(allSelectCombo)) ? comboWord : "";
      }
      String branchMaxLength = PropertyService.getInstance().getProperty("aml.config", "branchMaxLength");
      html = html + "&nbsp;&nbsp;&nbsp;&nbsp;<input type='text' id='" + name + "' name='" + name + "' size='" + (Integer.parseInt(branchMaxLength) + 1) + "' ";
      if ((branchMaxLength != null) && (!"".equals(branchMaxLength))) {
        html = html + "maxlength='" + branchMaxLength + "' ";
      }
      html = html + " style='text-align:center;' onblur='setScName()' onclick='this.select();' onkeydown='eventEnterKeyBranch();' ";
      if (!"Y".equals(masterBranch)) {
        html = html + "readonly='readonly'";
      }
      html = html + "/>";

      html = html + "&nbsp;&nbsp;&nbsp;&nbsp;<button type='button' class='btn-36' onclick='popupBranchWindow(\"brn_list\",\"" + name + "\",\"" + name + "_NM\")'>";
      html = html + getHelperMsg("AML_90_01_01_01_btn_01", "검색", new String[0]) +"</button>";
      if (!isHidden) {
        html = html + "<input type='text' id='" + name + "_NM' name='" + name + "_NM' size='15' readonly='readonly' />";
      } else {
        html = html + " <input type='hidden' id='" + name + "_NM' name='" + name + "_NM'/>";
      }
      html = html + "<select id='brn_list' name='brn_list' style='display:none' class='dropdown'>";
      if (((initValue == null) || ("".equals(initValue))) && ("N".equals(masterBranch))) {
        initValue = this.sessionAML.getsAML_BDPT_CD();
      }
      html = html + commonUtil.setComboHtmlBranch(this.sessionAML, initValue, fcw);
      html = html + " </select> ";
    }
    return html;
  }

  public String getBranchSearchItem(String config)
  {
    if ((config != null) && (!"".equals(config.trim())))
    {
      JSONObject json = toJSONObject(config);
      return getBranchSearchItem(
        json.optString("msgID"),
        json.optString("defaultValue"),
        json.optString("name"),
        json.optString("firstComboWord"),
        json.optString("initValue"),
        json.optString("allSelectCombo"),
        "true".equals(json.optString("isHidden")));
    }
    return "<script>alert('" + getHelperMsg("msg_common_00_008", "CondEL.getBranchSearchItem ï¿½ï¿½ ï¿½ï¿½ï¿½Ç±×·ï¿½ï¿½Ì¼ï¿½ ï¿½ï¿½ï¿½ï¿½ ï¿½Ã¹Ù¸ï¿½ï¿½ï¿½ ï¿½Ê½ï¿½ï¿½Ï´ï¿½.", new String[0]) + "');</script>";
  }

  public String getBranchSearchItem(String msgID, String defaultValue, String name, String firstComboWord, String initValue, String allSelectCombo, boolean isHidden)
  {
    return  getBranchSearch(msgID, defaultValue, name, firstComboWord, initValue, allSelectCombo, isHidden) ;
  }

  public String getInputCustomerNo(String config)
  {
    if ((config != null) && (!"".equals(config.trim()))) {
      try
      {
        JSONObject json = toJSONObject(config);
        String msgID = json.optString("msgID");
        String defaultValue = json.optString("defaultValue");
        if (!"".equals(msgID)) {
          return getInputCustomerNo(
            msgID,
            defaultValue,
            json.optString("name"),
            json.optString("initValue"),
            json.optString("className"),
            json.optString("style"),
            json.optString("attr"),
            json.optString("size"),
            json.optString("maxLength"));
        }
        return getInputCustomerNo(
          json.optString("name"),
          json.optString("initValue"),
          json.optString("className"),
          json.optString("style"),
          json.optString("attr"),
          json.optString("size"),
          json.optString("maxLength"));
      } catch (JSONException e) {
    	  return getInputCustomerNo(config, null, null, null, null, null, null);
      } catch (Exception e) {
        return getInputCustomerNo(config, null, null, null, null, null, null);
      }
    }
    return "<script>alert('" + getHelperMsg("msg_common_00_001", "CondEL.getInputCustomerNo ï¿½ï¿½ ï¿½ï¿½ï¿½Ç±×·ï¿½ï¿½Ì¼ï¿½ ï¿½ï¿½ï¿½ï¿½ ï¿½Ã¹Ù¸ï¿½ï¿½ï¿½ ï¿½Ê½ï¿½ï¿½Ï´ï¿½.", new String[0]) + "');</script>";
  }

  public String getInputCustomerNo(String msgID, String defaultValue, String name, String initValue, String className, String style, String attr, String size, String maxLength)
  {
    return getLabel(msgID, defaultValue) + getInputCustomerNo(name, initValue, className, style, attr, size, maxLength);
  }

  public String getInputCustomerNo(String name, String initValue, String className, String style, String attr)
  {
    return getInputCustomerNo(name, initValue, className, style, attr, null, null);
  }

  public String getInputCustomerNo(String name, String initValue, String className, String style, String attr, String size, String maxLength)
  {
    String html = "";
    if ((this.sessionAML != null) && (this.request != null))
    {
      html = html + "<div class='content'>";
      html = html + "<input type='text' id='" + name + "' name='" + name + "' ";
      html = html + "size='" + ((size != null) && (!"".equals(size.trim())) ? size : "16") + "' ";
      html = html + "maxlength='" + ((maxLength != null) && (!"".equals(maxLength.trim())) ? maxLength : "14") + "' ";
      if ((initValue != null) && (!"".equals(initValue.trim()))) {
        html = html + "value='" + XMLHelper.normalize(initValue) + "' ";
      }
      if ((className != null) && (!"".equals(className.trim()))) {
        //html = html + "class='" + className + "' ";
      } else {
        //html = html + "class='search-input wide' ";
      }
      if ((style != null) && (!"".equals(style.trim()))) {
        html = html + "style='" + style + "' ";
      }
      if ((attr != null) && (!"".equals(attr.trim()))) {
        html = html + "attr ";
      }
      html = html + "/>";
    }
    html = html + "</div>";
    return html;
  }

  public String getInputCustomerNoItem(String config)
  {
    if ((config != null) && (!"".equals(config.trim()))) {
      try
      {
        JSONObject json = toJSONObject(config);
        return getInputCustomerNoItem(
          json.optString("msgID"),
          json.optString("defaultValue"),
          json.optString("name"),
          json.optString("initValue"),
          json.optString("className"),
          json.optString("style"),
          json.optString("attr"),
          json.optString("size"),
          json.optString("maxLength"));
      }
      catch (JSONException e)
      {
    	  return getInputCustomerNoItem(config, null, null, null, null, null, null, null, null);
      }
      catch (Exception e)
      {
        return getInputCustomerNoItem(config, null, null, null, null, null, null, null, null);
      }
    }
    //return "<script>alert('" + getHelperMsg("msg_common_00_009", "CondEL.getInputCustomerNoItem ï¿½ï¿½ ï¿½ï¿½ï¿½Ç±×·ï¿½ï¿½Ì¼ï¿½ ï¿½ï¿½ï¿½ï¿½ ï¿½Ã¹Ù¸ï¿½ï¿½ï¿½ ï¿½Ê½ï¿½ï¿½Ï´ï¿½.", new String[0]) + "');</script>";
    return "<script>alert('"+getHelperMsg("msg_common_00_000", "CondEL.getBranchSearch 의 컨피그레이션 값이 올바르지 않습니다.", new String[0])+"');</script>";
  }

  public String getInputCustomerNoItem(String msgID, String devaultValue, String name, String initValue, String className, String style, String attr, String size, String maxLength)
  {
    return "<div class='cond-item'>" + getInputCustomerNo(msgID, devaultValue, name, initValue, className, style, attr, size, maxLength) + "</div>";
  }

  public String getInputCustomerNoSearch(String config)
  {
    if ((config != null) && (!"".equals(config.trim()))) {
      try
      {
        JSONObject json = toJSONObject(config);
        String msgID = json.optString("msgID");
        String defaultValue = json.optString("defaultValue");
        if (!"".equals(msgID)) {
          return getInputCustomerNo(
            msgID,
            defaultValue,
            json.optString("name"),
            json.optString("initValue"),
            json.optString("className"),
            json.optString("style"),
            json.optString("attr"),
            json.optString("size"),
            json.optString("maxLength"));
        }
        return getInputCustomerNo(
          json.optString("name"),
          json.optString("initValue"),
          json.optString("className"),
          json.optString("style"),
          json.optString("attr"),
          json.optString("size"),
          json.optString("maxLength"));
      } catch (JSONException e) {
    	  return getInputCustomerNoSearch(config, null, null, null, null, null, null);
      } catch (Exception e) {
        return getInputCustomerNoSearch(config, null, null, null, null, null, null);
      }
    }
    //return "<script>alert('" + getHelperMsg("msg_common_00_001", "CondEL.getInputCustomerNo ï¿½ï¿½ ï¿½ï¿½ï¿½Ç±×·ï¿½ï¿½Ì¼ï¿½ ï¿½ï¿½ï¿½ï¿½ ï¿½Ã¹Ù¸ï¿½ï¿½ï¿½ ï¿½Ê½ï¿½ï¿½Ï´ï¿½.", new String[0]) + "');</script>";
    return "<script>alert('"+getHelperMsg("msg_common_00_000", "CondEL.getBranchSearch 의 컨피그레이션 값이 올바르지 않습니다.", new String[0])+"');</script>";
  }

  public String getInputCustomerNoSearch(String msgID, String defaultValue, String name, String initValue, String className, String style, String attr, String size, String maxLength)
  {
    return getLabel(msgID, defaultValue) + getInputCustomerNoSearch(name, initValue, className, style, attr, size, maxLength);
  }

  public String getInputCustomerNoSearch(String name, String initValue, String className, String style, String attr)
  {
    return getInputCustomerNoSearch(name, initValue, className, style, attr, null, null);
  }

  public String getInputCustomerNoSearch(String name, String initValue, String className, String style, String attr, String size, String maxLength)
  {
    String html = "";
    if ((this.sessionAML != null) && (this.request != null))
    {
      html = html + "<input type='text' class='search-input' id='" + name + "' name='" + name + "' ";
      html = html + "size='" + ((size != null) && (!"".equals(size.trim())) ? size : "16") + "' ";
      html = html + "maxlength='" + ((maxLength != null) && (!"".equals(maxLength.trim())) ? maxLength : "14") + "' ";
      if ((initValue != null) && (!"".equals(initValue.trim()))) {
        html = html + "value='" + XMLHelper.normalize(initValue) + "' ";
      }
      if ((className != null) && (!"".equals(className.trim()))) {
        //html = html + "class='" + className + "' ";
      } else {
        //html = html + "class='search-input wide' ";
      }
      if ((style != null) && (!"".equals(style.trim()))) {
        html = html + "style='" + style + "' ";
      }
      if ((attr != null) && (!"".equals(attr.trim()))) {
        html = html + "attr ";
      }
      html = html + "/>";
    }
    return html;
  }

  public String getInputCustomerNoItemSearch(String config)
  {
    if ((config != null) && (!"".equals(config.trim()))) {
      try
      {
        JSONObject json = toJSONObject(config);
        return getInputCustomerNoItem(
          json.optString("msgID"),
          json.optString("defaultValue"),
          json.optString("name"),
          json.optString("initValue"),
          json.optString("className"),
          json.optString("style"),
          json.optString("attr"),
          json.optString("size"),
          json.optString("maxLength"));
      }
      catch (JSONException e)
      {
    	  return getInputCustomerNoSearchItem(config, null, null, null, null, null, null, null, null);
      }
      catch (Exception e)
      {
        return getInputCustomerNoSearchItem(config, null, null, null, null, null, null, null, null);
      }
    }
    return "<script>alert('" + getHelperMsg("msg_common_00_009", "CondEL.getInputCustomerNoItem ï¿½ï¿½ ï¿½ï¿½ï¿½Ç±×·ï¿½ï¿½Ì¼ï¿½ ï¿½ï¿½ï¿½ï¿½ ï¿½Ã¹Ù¸ï¿½ï¿½ï¿½ ï¿½Ê½ï¿½ï¿½Ï´ï¿½.", new String[0]) + "');</script>";
  }

  public String getInputCustomerNoSearchItem(String msgID, String devaultValue, String name, String initValue, String className, String style, String attr, String size, String maxLength)
  {
    return "<div class='cond-item'>" + getInputCustomerNoSearch(msgID, devaultValue, name, initValue, className, style, attr, size, maxLength) + "</div>";
  }



  public String getInputDate(String config)
  {
    if ((config != null) && (!"".equals(config.trim()))) {
      try
      {
        JSONObject json = toJSONObject(config);
        return getInputDate(
          json.optString("name"),
          json.optString("initValue"),
          json.optString("formatType"));
      }
      catch (JSONException localException) {Log.logAML(1, localException);}
      catch (Exception localException) {Log.logAML(1, localException);}
    }
    return "<script>alert('" + getHelperMsg("msg_common_00_002", "CondEL.getInputDate ï¿½ï¿½ ï¿½ï¿½ï¿½Ç±×·ï¿½ï¿½Ì¼ï¿½ ï¿½ï¿½ï¿½ï¿½ ï¿½Ã¹Ù¸ï¿½ï¿½ï¿½ ï¿½Ê½ï¿½ï¿½Ï´ï¿½.", new String[0]) + "');</script>";
  }

  public String getInputDate(String name, String initValue, String formatType)
  {
    String html = "";
    if ((this.sessionAML != null) && (this.request != null))
    {
      html = html + "<input type='text' id='" + name + "' name='" + name + "' size='10' maxlength='10'  />";
      html = html + "<script>setupCalendar('" + name + "','" + initValue + "','" + formatType + "');</script>";
    }
    return html;
  }

  public String getInputDateDx(String config)
  {
    if ((config != null) && (!"".equals(config.trim()))) {
      try
      {
        JSONObject json = toJSONObject(config);
        String msgID = json.optString("msgID");
        String defaultValue = json.optString("defaultValue");
        if (!"".equals(msgID)) {
          return getInputDateDx(
            msgID,
            defaultValue,
            json.optString("name"),
            json.optString("initValue"),
            json.optString("formatType"));
        }
        return getInputDateDx(
          json.optString("name"),
          json.optString("initValue"),
          json.optString("formatType"));
      }
      catch (JSONException localException) {Log.logAML(1, localException);}
      catch (Exception localException) {Log.logAML(1, localException);}
    }
    return "<script>alert('" + getHelperMsg("msg_common_00_003", "CondEL.getInputDateDx ï¿½ï¿½ ï¿½ï¿½ï¿½Ç±×·ï¿½ï¿½Ì¼ï¿½ ï¿½ï¿½ï¿½ï¿½ ï¿½Ã¹Ù¸ï¿½ï¿½ï¿½ ï¿½Ê½ï¿½ï¿½Ï´ï¿½.", new String[0]) + "');</script>";
  }

  public String getInputDateDx(String name, String initValue)
  {
    String html = "";
    if ((this.sessionAML != null) && (this.request != null))
    {
      html = html + "<div id='" + name + "' ></div>";
      html = html + "<script>setupCalendarDx('" + name + "','" + ((initValue != null) && (!"".equals(initValue.trim())) ? initValue : "") + "','date');</script>";
    }
    return html;
  }

  public String getInputDateDx(String name, String initValue, String formatType)
  {
    String html = "";
    if ((this.sessionAML != null) && (this.request != null))
    {
      html = html + "<div id='" + name + "'></div>";
      html = html + "<script>setupCalendarDx('" + name + "','" + ((initValue != null) && (!"".equals(initValue.trim())) ? initValue : "") + "','" + formatType + "');</script>";
    }
    return html;
  }

  public String getInputDateDxJspf(String name, String initValue)
  {
    String html = "";
    if ((this.sessionAML != null) && (this.request != null)) {
      html = html + "<div id='" + name + "' ></div>";
    }
    return html;
  }

  public String getInputDateDxJspf(String name, String initValue, String formatType)
  {
    String html = "";
    if ((this.sessionAML != null) && (this.request != null)) {
      html = html + "<div id='" + name + "' ></div>";
    }
    return html;
  }

  public String getInputDateDx(String msgID, String defaultValue, String name, String initValue)
  {
    return getLabel(msgID, defaultValue) + "<div class='content'><div class='calendar'>" +getInputDateDx(name, initValue, "date")+ "</div></div>";
  }

  public String getInputDateDx(String msgID, String defaultValue, String name, String initValue, String formatType)
  {
    return getLabel(msgID, defaultValue) + "<div class='content'><div class='calendar'>" + getInputDateDx(name, initValue, formatType)+ "</div></div>";
  }

  public String getInputDateDxItem(String config)
  {
    if ((config != null) && (!"".equals(config.trim()))) {
      try
      {
        JSONObject json = toJSONObject(config);
        return getInputDateDxItem(
          json.optString("msgID"),
          json.optString("defaultValue"),
          json.optString("name"),
          json.optString("initValue"),
          json.optString("formatType"));
      }
      catch (JSONException localException) {Log.logAML(1, localException);}
      catch (Exception localException) {Log.logAML(1, localException);}
    }
    return "<script>alert('" + getHelperMsg("msg_common_00_010", "CondEL.getInputDateDxItem ï¿½ï¿½ ï¿½ï¿½ï¿½Ç±×·ï¿½ï¿½Ì¼ï¿½ ï¿½ï¿½ï¿½ï¿½ ï¿½Ã¹Ù¸ï¿½ï¿½ï¿½ ï¿½Ê½ï¿½ï¿½Ï´ï¿½.", new String[0]) + "');</script>";
  }

  public String getInputDateDxItem(String msgID, String defaultValue, String name, String initValue, String formatType)
  {
    return "<div class='content'><div class='calendar'>" + getInputDateDx(msgID, defaultValue, name, initValue, formatType)+ "</div></div>";
  }
  public String getInputDateDxPair(String name1, String initValue1, String name2, String initValue2)
  {
    return   "<div class='content'><div class='calendar'>" + getInputDateDx(name1, initValue1, "date") + "~" + getInputDateDx(name2, initValue2, "date") + "</div></div>";
  }

  public String getInputDateDxPair(String name1, String initValue1, String name2, String initValue2, String formatType)
  {
    return  "<div class='content'><div class='calendar'>" + getInputDateDx(name1, initValue1, formatType) + "~" + getInputDateDx(name2, initValue2, formatType)+ "</div></div>";
  }

  public String getInputDateDxPairJspf(String name1, String initValue1, String name2, String initValue2)
  {
    return "<div class='content'><div class='calendar'>" + getInputDateDxJspf(name1, initValue1, "date") + "~" + getInputDateDxJspf(name2, initValue2, "date")+ "</div>";
  }

  public String getInputDateDxPairJspf(String name1, String initValue1, String name2, String initValue2, String formatType)
  {
    return "<div class='content'>" + getInputDateDxJspf(name1, initValue1, formatType) + "~" + getInputDateDxJspf(name2, initValue2, formatType)+ "</div></div>";
  }

  public String getInputDateDxPair(String msgID, String defaultValue, String name1, String initValue1, String name2, String initValue2)
  {
    return getLabel(msgID, defaultValue) + getInputDateDxPair(name1, initValue1, name2, initValue2);
  }

  public String getInputDateDxPair(String msgID, String defaultValue, String name1, String initValue1, String name2, String initValue2, String formatType)
  {
    return getLabel(msgID, defaultValue) + getInputDateDxPair(name1, initValue1, name2, initValue2, formatType);
  }

  public String getInputDateDxPair(String config)
  {
    if ((config != null) && (!"".equals(config.trim()))) {
      try
      {
        JSONObject json = toJSONObject(config);
        String msgID = json.optString("msgID");
        String defaultValue = json.optString("defaultValue");
        if (!"".equals(msgID)) {
          return getInputDateDxPair(
            msgID,
            defaultValue,
            json.optString("name1"),
            json.optString("initValue1"),
            json.optString("name2"),
            json.optString("initValue2"));
        }
        return getInputDateDxPair(
          json.optString("name1"),
          json.optString("initValue1"),
          json.optString("name2"),
          json.optString("initValue2"));
      }
      catch (JSONException localException) {Log.logAML(1, localException);}
      catch (Exception localException) {Log.logAML(1, localException);}
    }
    return "<script>alert('" + getHelperMsg("msg_common_00_011", "CondEL.getInputDateDxPair ï¿½ï¿½ ï¿½ï¿½ï¿½Ç±×·ï¿½ï¿½Ì¼ï¿½ ï¿½ï¿½ï¿½ï¿½ ï¿½Ã¹Ù¸ï¿½ï¿½ï¿½ ï¿½Ê½ï¿½ï¿½Ï´ï¿½.", new String[0]) + "');</script>";
  }

  public String getInputDateDxPairItem(String msgID, String defaultValue, String name1, String initValue1, String name2, String initValue2)
  {
    return "<div class='content'>" + getInputDateDxPair(msgID, defaultValue, name1, initValue1, name2, initValue2) + "</div>";
  }

  public String getInputDateDxPairItem(String config)
  {
    if ((config != null) && (!"".equals(config.trim()))) {
      try
      {
        JSONObject json = toJSONObject(config);
        return getInputDateDxPair(
          json.optString("msgID"),
          json.optString("defaultValue"),
          json.optString("name1"),
          json.optString("initValue1"),
          json.optString("name2"),
          json.optString("initValue2"));
      }
      catch (JSONException localException) {Log.logAML(1, localException);}
      catch (Exception localException) {Log.logAML(1, localException);}
    }
    return "<script>alert('" + getHelperMsg("msg_common_00_012", "CondEL.getInputDateDxPairItem ï¿½ï¿½ ï¿½ï¿½ï¿½Ç±×·ï¿½ï¿½Ì¼ï¿½ ï¿½ï¿½ï¿½ï¿½ ï¿½Ã¹Ù¸ï¿½ï¿½ï¿½ ï¿½Ê½ï¿½ï¿½Ï´ï¿½.", new String[0]) + "');</script>";
  }

  public String getInputText(String config)
  {
    if ((config != null) && (!"".equals(config.trim()))) {
      try
      {
        JSONObject json = toJSONObject(config);
        String msgID = json.optString("msgID");
        String defaultValue = json.optString("defaultValue");
        if (!"".equals(msgID)) {
          return getInputText(
            msgID,
            defaultValue,
            json.optString("name"),
            json.optString("initValue"),
            json.optString("className"),
            json.optString("style"),
            json.optString("attr"),
            json.optString("size"),
            json.optString("maxLength"));
        }
        return getInputText(
          json.optString("name"),
          json.optString("initValue"),
          json.optString("className"),
          json.optString("style"),
          json.optString("attr"),
          json.optString("size"),
          json.optString("maxLength"));
      }
      catch (JSONException e)
      {
    	  return getInputText(config, null, null, null, null, null, null);
      }
      catch (Exception e)
      {
        return getInputText(config, null, null, null, null, null, null);
      }
    }
    return "<script>alert('" + getHelperMsg("msg_common_00_001", "CondEL.getInputCustomerNo ï¿½ï¿½ ï¿½ï¿½ï¿½Ç±×·ï¿½ï¿½Ì¼ï¿½ ï¿½ï¿½ï¿½ï¿½ ï¿½Ã¹Ù¸ï¿½ï¿½ï¿½ ï¿½Ê½ï¿½ï¿½Ï´ï¿½.", new String[0]) + "');</script>";
  }

  public String getInputText(String msgID, String defaultValue, String name, String initValue, String className, String style, String attr, String size, String maxLength)
  {
    return getLabel(msgID, defaultValue) + getInputText(name, initValue, className, style, attr, size, maxLength);
  }

  public String getInputText(String name, String initValue, String className, String style, String attr)
  {
    return getInputText(name, initValue, className, style, attr, null, null);
  }

  public String getInputText(String name, String initValue, String className, String style, String attr, String size, String maxLength)
  {
    String html = "";
    if ((this.sessionAML != null) && (this.request != null))
    {
      html = html + "<input type='text' id='" + name + "' name='" + name + "' ";
      html = html + "size='" + ((size != null) && (!"".equals(size.trim())) ? size : "16") + "' ";
      html = html + "maxlength='" + ((maxLength != null) && (!"".equals(maxLength.trim())) ? maxLength : "14") + "' ";
      if ((initValue != null) && (!"".equals(initValue.trim()))) {
        html = html + "value='" + XMLHelper.normalize(initValue) + "' ";
      }
      if ((className != null) && (!"".equals(className.trim()))) {
      //  html = html + "class='" + className + "' ";
      } else {
     //   html = html + "class='cond-input-text' ";
      }
      if ((style != null) && (!"".equals(style.trim()))) {
        html = html + "style='" + style + "' ";
      }
      if ((attr != null) && (!"".equals(attr.trim()))) {
        html = html + "attr ";
      }
      html = html + "/>";
    }
    return html;
  }

  public String getInputTextItem(String config)
  {
    if ((config != null) && (!"".equals(config.trim()))) {
      try
      {
        JSONObject json = toJSONObject(config);
        return getInputText(
          json.optString("msgID"),
          json.optString("defaultValue"),
          json.optString("name"),
          json.optString("initValue"),
          json.optString("className"),
          json.optString("style"),
          json.optString("attr"),
          json.optString("size"),
          json.optString("maxLength"));
      }
      catch (JSONException e)
      {
    	  return getInputTextItem(config, null, null, null, null, null, null, null, null);
      }
      catch (Exception e)
      {
        return getInputTextItem(config, null, null, null, null, null, null, null, null);
      }
    }
    return "<script>alert('" + getHelperMsg("msg_common_00_009", "CondEL.getInputCustomerNoItem ï¿½ï¿½ ï¿½ï¿½ï¿½Ç±×·ï¿½ï¿½Ì¼ï¿½ ï¿½ï¿½ï¿½ï¿½ ï¿½Ã¹Ù¸ï¿½ï¿½ï¿½ ï¿½Ê½ï¿½ï¿½Ï´ï¿½.", new String[0]) + "');</script>";
  }

  public String getInputTextItem(String msgID, String devaultValue, String name, String initValue, String className, String style, String attr, String size, String maxLength)
  {
    return "<div class='cond-item'>" + getInputText(msgID, devaultValue, name, initValue, className, style, attr, size, maxLength) + "</div>";
  }

  public String getLabel(String config)
  {
    if ((config != null) && (!"".equals(config.trim()))) {
      try
      {
        JSONObject json = toJSONObject(config);
        return getLabel(
          json.optString("msgID"),
          json.optString("initValue"));
      }
      catch (JSONException localException) {Log.logAML(1, localException);}
      catch (Exception localException) {Log.logAML(1, localException);}
    }
    return "<script>alert('" + getHelperMsg("msg_common_00_004", "CondEL.getLabel ï¿½ï¿½ ï¿½ï¿½ï¿½Ç±×·ï¿½ï¿½Ì¼ï¿½ ï¿½ï¿½ï¿½ï¿½ ï¿½Ã¹Ù¸ï¿½ï¿½ï¿½ ï¿½Ê½ï¿½ï¿½Ï´ï¿½.", new String[0]) + "');</script>";
  }

  public String getLabel(String msgID, String defaultValue)
  {
//    String html = "";
//    if ((this.sessionAML != null) && (this.request != null))
//    {
//      String label = null;
//      try
//      {
//        label = getBundleMsg(msgID, defaultValue);
//      }
//      catch (JSONException localException) {Log.logAML(1, localException);}
//      catch (Exception localException) {Log.logAML(1, localException);}
//      html = html + "<div class='title'><span class='txt'>"+ label + "</span></div>";
//      //html = html + "<div class='title'><span class='txt' title='"+label+"'>"+ label + "</span></div>"; //툴팁기능
//    }
//    return html;
	  return getLabel(msgID, defaultValue, "");
  }

  public String getLabel(String msgID, String defaultValue, String style) {
	String html = "";
    if ((this.sessionAML != null) && (this.request != null)) {
      String label = null;
      try {
        label = getBundleMsg(msgID, defaultValue);
      }
      catch (JSONException localException) {Log.logAML(1, localException);}
      catch (Exception localException) {Log.logAML(1, localException);}
      if (!"".equals(style)) {
    	  html = html + "<div class='title' " + style + "'><span class='txt'>";
      } else {
    	  html = html + "<div class='title'><span class='txt'>";
      }
      html += label + "</span></div>";
      //html = html + "<div class='title'><span class='txt' title='"+label+"'>"+ label + "</span></div>"; //툴팁기능
    }
	return html;
  }

  public String getSelect(String config)
  {
    if ((config != null) && (!"".equals(config.trim()))) {
      try
      {
        JSONObject json = toJSONObject(config);
        String msgID = json.optString("msgID");
        String defaultValue = json.optString("defaultValue");
        if (!"".equals(msgID)) {
          return getSelect(
            msgID,
            defaultValue,
            json.optString("selectID"),
            json.optString("width"),
            json.optString("sqlID"),
            json.optString("code"),
            json.optString("initValue"),
            json.optString("firstComboWord"));
        }
        return getSelect(
          json.optString("selectID"),
          json.optString("width"),
          json.optString("sqlID"),
          json.optString("code"),
          json.optString("initValue"),
          json.optString("firstComboWord"));
      }
      catch (JSONException localException) {Log.logAML(1, localException);}
      catch (Exception localException) {Log.logAML(1, localException);}
    }
    return "<script>alert('" + getHelperMsg("msg_common_00_005", "CondEL.getSelect ï¿½ï¿½ ï¿½ï¿½ï¿½Ç±×·ï¿½ï¿½Ì¼ï¿½ ï¿½ï¿½ï¿½ï¿½ ï¿½Ã¹Ù¸ï¿½ï¿½ï¿½ ï¿½Ê½ï¿½ï¿½Ï´ï¿½.", new String[0]) + "');</script>";
  }

  public String getSelect(String msgID, String defaultValue, String selectID, String width, String sqlID, String code, String initValue, String firstComboWord)
  {
    return getLabel(msgID, defaultValue) + getSelect(selectID, width, sqlID, code, initValue, firstComboWord);
  }

  public String getSelect(String selectID, String width, String sqlID, String code, String initValue, String firstComboWord)
  {
    String html = "";
    String widthStr = "style='width:" + width;
    try
    {
      //Float.parseFloat(width);
      widthStr = widthStr + "px'>";
    }
    catch (NumberFormatException e)
    {
      widthStr = widthStr + "'>";
    }
    if ((this.sessionAML != null) && (this.request != null))
    {
      html = html + "<div class='content'>";
      html = html + "<select id='" + selectID + "' name='" + selectID + "' class='dropdown' " + widthStr;
      html = html + getSelectOption(sqlID, code, initValue, firstComboWord, "");
      html = html + "</select>";
      html = html + "</div>";
    }
    return html;
  }

  public String getSelect(String msgID, String defaultValue, String selectID, String width, String sqlID, String code, String initValue, String firstComboWord, String firstComboVal)
  {
    return getLabel(msgID, defaultValue) + getSelect(selectID, width, sqlID, code, initValue, firstComboWord, firstComboVal);
  }

  public String getSelect(String selectID, String width, String sqlID, String code, String initValue, String firstComboWord, String firstComboVal)
  {
    String html = "";
    if ((this.sessionAML != null) && (this.request != null))
    {
      html = html + "<div class='content'>";
      html = html + "<select id='" + selectID + "' name='" + selectID + "' class='dropdown' " + ((width != null) && (!"".equals(width.trim())) ? "style='width:" + width + "px'>" : ">");
      html = html + getSelectOption(sqlID, code, initValue, firstComboWord, firstComboVal);
      html = html + "</select>";
      html = html + "</div>";
    }
    return html;
  }
  public String getSelect(String msgID, String defaultValue, String selectID, String width, String sqlID, String code, String initValue, String firstComboWord, String firstComboVal, String changeFunction, String param, String val)
  {
	  return getLabel(msgID, defaultValue) + getSelect(selectID, width, sqlID, code, initValue, firstComboWord, firstComboVal, changeFunction, param, val);
  }

  public String getSelect(String selectID, String width, String sqlID, String code, String initValue, String firstComboWord, String firstComboVal, String changeFunction, String param, String val)
  {
	  String html = "";
	  if ((this.sessionAML != null) && (this.request != null))
	  {
		  html = html + "<div class='content'>";
		  html = html + "<select id='" + selectID + "' name='" + selectID + "' class='dropdown' " + "onchange='" + changeFunction +"("+param+")'" + ((width != null) && (!"".equals(width.trim())) ? "style='width:" + width + "px'>" : ">");
		  html = html + getSelectOption(sqlID, code, initValue, firstComboWord, firstComboVal);
		  html = html + "</select>";
		  html = html + "</div>";
	  }
	  return html;
  }

  public String getSelectItem(String config)
  {
    if ((config != null) && (!"".equals(config.trim()))) {
      try
      {
        JSONObject json = toJSONObject(config);
        return getSelectItem(
          json.optString("msgID"),
          json.optString("defaultValue"),
          json.optString("selectID"),
          json.optString("width"),
          json.optString("sqlID"),
          json.optString("code"),
          json.optString("initValue"),
          json.optString("firstComboWord"));
      }
      catch (JSONException localException) {Log.logAML(1, localException);}
      catch (Exception localException) {Log.logAML(1, localException);}
    }
    return "<script>alert('" + getHelperMsg("msg_common_00_006", "CondEL.getSelectItem ï¿½ï¿½ ï¿½ï¿½ï¿½Ç±×·ï¿½ï¿½Ì¼ï¿½ ï¿½ï¿½ï¿½ï¿½ ï¿½Ã¹Ù¸ï¿½ï¿½ï¿½ ï¿½Ê½ï¿½ï¿½Ï´ï¿½.", new String[0]) + "');</script>";
  }

  public String getSelectItem(String msgID, String defaultValue, String selectID, String width, String sqlID, String code, String initValue, String firstComboWord)
  {
    return  getLabel(msgID, defaultValue) + getSelect(selectID, width, sqlID, code, initValue, firstComboWord);
  }

  public String getSelectOption(String config)
  {
    if ((config != null) && (!"".equals(config.trim()))) {
      try
      {
        JSONObject json = toJSONObject(config);
        return getSelectOption(
          json.optString("sqlID"),
          json.optString("code"),
          json.optString("initValue"),
          json.optString("firstComboWord"),
          json.optString("firstComboVal"));
      }
      catch (JSONException e)
      {
    	  Log.logAML(1, e);
      }
      catch (Exception e)
      {
        Log.logAML(1, e);
      }
    }
    return "<script>alert('" + getHelperMsg("msg_common_00_007", "CondEL.getSelectOption ï¿½ï¿½ ï¿½ï¿½ï¿½Ç±×·ï¿½ï¿½Ì¼ï¿½ ï¿½ï¿½ï¿½ï¿½ ï¿½Ã¹Ù¸ï¿½ï¿½ï¿½ ï¿½Ê½ï¿½ï¿½Ï´ï¿½.", new String[0]) + "');</script>";
  }

  public String getSelectOption(String sqlID, String code, String initValue, String firstComboWord)
  {
    return getSelectOption(sqlID, code, initValue, firstComboWord, null);
  }

  public String getSelectOption(String sqlID, String code, String initValue, String firstComboWord, String firstComboVal)
  {
    String html = "";
    if ((this.sessionAML != null) && (this.request != null))
    {
      firstComboWord = getHelperMsg(firstComboWord, firstComboWord, new String[0]);
      if (sqlID != null) {
        html = html + commonUtil.setComboHtml(sqlID, code, initValue, firstComboWord, firstComboVal);
      } else if (code != null) {
        html = html + commonUtil.setComboHtmlJspeed(sqlID, code, initValue, firstComboWord, firstComboVal);
      }
    }
    return html;
  }

  /**
   * 검색조건의 레이블 및 <select> 와 <option> 엘리먼트를 생성하여 반환.<br>
   * msgID 파라미터 값 자체가 "" 이면 검색조건의 레이블은 생성하지 않는다
   * <p>
   * @param   config
   *              파라미터를 포함하고 있는 JSON 형태의 스트링
   *                  msgID           : 메시지 키, 파라미터 값 자체가 "" 이면 검색조건의 레이블은 생성하지 않는다
   *                 ,defaultValue    : 메시지 키가 존재하지 않을 경우
   *                 ,selectID        : <select> 엘리먼트의 id 및 name
   *                 ,width           : 가로 px 길이
   *                 ,sqlID           : 쿼리 아이디
   *                 ,code            : 코드(NIC92B.CD)
    *                ,initValue       : 초기값
   *                 ,firstComboWord  : 첫번째 콤보박스 단어(전체 or 선택 등등...)
   * @return  <code>String</code>
   *              <select><option/>...</select> 태그 html
   */
  public String getMultiSelect(String config)
  {
      if (config!=null && !"".equals(config.trim())) {
          try {
              JSONObject json = toJSONObject(config);
              String msgID        = json.optString("msgID"       );
              String defaultValue = json.optString("defaultValue");
              if (!"".equals(msgID)) {
                  return getMultiSelect(
                      msgID
                     ,defaultValue
                     ,json.optString("selectID"       )
                     ,json.optString("width"          )
                     ,json.optString("sqlID"          )
                     ,json.optString("code"           )
                     ,json.optString("initValue"      )
                     ,json.optString("firstComboWord" )
                  );
              } else {
                  return getMultiSelect(
                      json.optString("selectID"       )
                     ,json.optString("width"          )
                     ,json.optString("sqlID"          )
                     ,json.optString("code"           )
                     ,json.optString("initValue"      )
                     ,json.optString("firstComboWord" )
                  );
              }
          }catch (JSONException e) {
  				Log.logAML(Log.ERROR, e.getMessage());
    	  }catch (Exception e) {
  				Log.logAML(Log.ERROR, e.getMessage());
    	  }
      }
      return "<script>alert('"+getHelperMsg("msg_common_00_005", "CondEL.getSelect 의 컨피그레이션 값이 올바르지 않습니다.")+"');</script>";
  }

  /**
   * 검색조건의 레이블 및 <select> 와 <option> 엘리먼트를 생성하여 반환.
   * <p>
   * @param   msgID
   *              메시지 키
   * @param   defaultValue
   *              메시지 키가 존재하지 않을 경우
   * @param   selectID
   *              <select> 엘리먼트의 id 및 name
   * @param   width
   *              가로 px 길이
   * @param   sqlID
   *              쿼리 아이디
   * @param   code
   *              코드(NIC92B.CD)
   * @param   initValue
   *              초기값
   * @param   firstComboWord
   *              첫번째 콤보박스 단어(전체 or 선택 등등...)
   * @return  <code>String</code>
   *              <select><option/>...</select> 태그 html
   */
  public String getMultiSelect(String msgID, String defaultValue, String selectID, String width, String sqlID, String code, String initValue, String firstComboWord)
  { return getLabel(msgID, defaultValue) + getMultiSelect(selectID, width, sqlID, code, initValue, firstComboWord); }

  /**
   * 검색조건의 레이블 및 <select> 와 <option> 엘리먼트를 생성하여 반환.
   * <p>
   * @param   msgID
   *              메시지 키
   * @param   defaultValue
   *              메시지 키가 존재하지 않을 경우
   * @param   selectID
   *              <select> 엘리먼트의 id 및 name
   * @param   width
   *              가로 px 길이
   * @param   sqlID
   *              쿼리 아이디
   * @param   code
   *              코드(NIC92B.CD)
   * @param   initValue
   *              초기값
   * @param   firstComboWord
   *              첫번째 콤보박스 단어(전체 or 선택 등등...)
   * @param   firstComboVal
   *              첫번째 콤보박스 값
   * @return  <code>String</code>
   *              <select><option/>...</select> 태그 html
   */
  public String getMultiSelect(String msgID, String defaultValue, String selectID, String width, String sqlID, String code, String initValue, String firstComboWord, String firstComboVal)
  { return getLabel(msgID, defaultValue) + getMultiSelect(selectID, width, sqlID, code, initValue, firstComboWord); }

  /**
   * 검색조건의 레이블 및 <select> 와 <option> 엘리먼트를 생성하여 반환.
   * <p>
   * @param   msgID
   *              메시지 키
   * @param   defaultValue
   *              메시지 키가 존재하지 않을 경우
   * @param   selectID
   *              <select> 엘리먼트의 id 및 name
   * @param   width
   *              가로 px 길이
   * @param   sqlID
   *              쿼리 아이디
   * @param   code
   *              코드(NIC92B.CD)
   * @param   initValue
   *              초기값
   * @param   firstComboWord
   *              첫번째 콤보박스 단어(전체 or 선택 등등...)
   * @return  <code>String</code>
   *              <div>...</div> 태그 html
   */
  public String getMultiSelect(String selectID, String width, String sqlID, String code, String initValue, String firstComboWord)
  {
      String html = "";
      String widthStr  = "style='display:inline-block;width:"+width;
      DataObj output = new DataObj();
      JSONArray dataSource = new JSONArray();
      try {
          widthStr  += "px'></div>";
          String[] condition = StringHelper.split(code, ",");
          DataObj dbInput = new DataObj();

          dbInput.put("CD", condition[0].trim());
          for (int i = 0; i < condition.length; i++) {
              dbInput.put("param" + i, condition[i].trim());
          }

          if ("".equals(code)) { condition = new String[0]; }

          if (sqlID != null && !"".equals(sqlID.trim())) {
              if (sqlID.startsWith("MDAO.")) {
                  output = MDaoUtilSingle.getData(sqlID.replaceFirst("MDAO.",""),condition);
              } else {
                  output = MDaoUtilSingle.getData(sqlID, dbInput);
              }
          } else {
              output = MDaoUtilSingle.getData("AML_00_00_00_00_common_getComboData_NCC92B", dbInput);
          }
          if (output.getCount("CODE") > 0) {
              JSONObject codeObject = null;
              for ( int i = 0; i < output.getCount("CODE"); i++ ) {
                  codeObject = new JSONObject();
                  codeObject.put("CODE", output.getText("CODE", i));
                  codeObject.put("NAME", output.getText("NAME", i));
                  dataSource.add(codeObject);
              }
          }
      } catch (NumberFormatException e) {
          widthStr  += "'></div>";
      } catch (Exception e) {
          widthStr  += "'></div>";
      }
      if (this.sessionAML!=null && this.request!=null) {
          firstComboWord = getHelperMsg(firstComboWord, firstComboWord, new String[0]);
          html += "<div class='content'>";
          html += "<div id='"+selectID+"' name='"+selectID+"' "+(widthStr);
          html += "<script>setupMultiSelectBox('"+selectID+"','"+(initValue!=null && !"".equals(initValue.trim())?initValue:"")+"','"+firstComboWord+"',"+dataSource+");</script>";
          html += "</div>";
      }
      return html;
  }

  public static void setup(PageContext pageContext)
  {
    setup("condel", pageContext, CondEL.class);
  }
}
