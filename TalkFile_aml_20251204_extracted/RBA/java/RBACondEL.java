package com.gtone.aml.basic.jspeed.base.el;

import java.util.HashMap;

import javax.servlet.jsp.PageContext;

import com.gtone.aml.admin.AMLException;
import com.gtone.aml.basic.common.data.DataObj;
import com.gtone.aml.basic.common.log.Log;
import com.gtone.aml.dao.common.MDaoUtilSingle;
import com.gtone.aml.server.common.commonUtil;

import jspeed.base.util.StringHelper;
import net.sf.json.JSONException;
import net.sf.json.JSONObject;

public class RBACondEL extends AbsEL {
	public static final String COMMON_COMBO_ALL_CODE = "ALL";

	public RBACondEL() {}

	public RBACondEL(PageContext pageContext) {
		super(pageContext);
	}

	public String getRBALabel(String config) {
		if ( (config != null) && (!"".equals(config.trim())) ) {
			try {
				JSONObject json = toJSONObject(config);
				return getRBALabel(json.optString("msgID"), json.optString("initValue"));
			} catch (JSONException localException) {
				Log.logAML(1, localException);
			} catch (Exception localException) {
				Log.logAML(1, localException);
			}
		}
		return "<script>alert('" + getHelperMsg("msg_common_00_021", "RBACondEL.getRBALabel 의 컨피그레이션 값이 올바르지 않습니다.", new String[0]) + "');</script>";
	}

	public String getRBALabel(String msgID, String defaultValue) {
		String html = "";
		if ( (this.sessionAML != null) && (this.request != null) ) {
			String label = null;
			try {
				label = getBundleMsg(msgID, defaultValue);
			} catch (RuntimeException localException) {
				Log.logAML(1, localException);
			} catch (Exception localException) {
				Log.logAML(1, localException);
			}
			html = html + "<span><i class='fa fa-chevron-circle-right' style='position:relative;top:1px;' ></i><span class='cond-label'>&nbsp;" + label + "</span></span>";
		}
		return html;
	}

	public String getRBASelect(String config) {
		if ( (config != null) && (!"".equals(config.trim())) ) {
			try {
				JSONObject json = toJSONObject(config);
				String msgID = json.optString("msgID");
				String defaultValue = json.optString("defaultValue");
				if ( !"".equals(msgID) ) {
					return getRBASelect(msgID, defaultValue, json.optString("selectID"), json.optString("width"), json.optString("sqlID"), json.optString("code"), json.optString("initValue"), json.optString("firstComboWord"), json.optString("eventFunction"));
				}

				return getRBASelect(json.optString("selectID"), json.optString("width"), json.optString("sqlID"), json.optString("code"), json.optString("initValue"), json.optString("firstComboWord"), json.optString("eventFunction"));
			} catch (JSONException localException) {
				Log.logAML(1, localException);
			} catch (Exception localException) {
				Log.logAML(1, localException);
			}
		}
		return "<script>alert('" + getHelperMsg("msg_common_00_022", "RBACondEL.getRBASelect 의 컨피그레이션 값이 올바르지 않습니다.", new String[0]) + "');</script>";
	}

	public String getRBASelect(String msgID, String defaultValue, String selectID, String width, String sqlID, String code, String initValue, String firstComboWord, String eventFunction) {
		return getRBALabel(msgID, defaultValue) + getRBASelect(selectID, width, sqlID, code, initValue, firstComboWord, eventFunction);
	}

	public String getRBASelect(String selectID, String width, String sqlID, String code, String initValue, String firstComboWord, String eventFunction) {
		String html = "";
		if ( (this.sessionAML != null) && (this.request != null) ) {
			html += "<div class='content'>";
			html = html + "<select id='" + selectID + "' name='" + selectID + "' class='dropdown' " + ((eventFunction != null) && (!"".equals(eventFunction.trim())) ? "onchange='" + eventFunction + "'" : " ") + ((width != null) && (!"".equals(width.trim())) ? "style='width:" + width + "'" : " ") + ">";
			html = html + getRBASelectOption(sqlID, code, initValue, firstComboWord);
			html = html + "</select>";
			html = html + "</div>";
		}
		return html;
	}

	public String getRBASelect(String msgID, String defaultValue, String selectID, String width, String sqlID, String code, String initValue, String firstComboWord, String firstComboVal, String eventFunction) {
		return getRBALabel(msgID, defaultValue) + getRBASelect(selectID, width, sqlID, code, initValue, firstComboWord, firstComboVal, eventFunction);
	}

	public String getRBASelect(String selectID, String width, String sqlID, String code, String initValue, String firstComboWord, String firstComboVal, String eventFunction) {
		String html = "";
		if ( (this.sessionAML != null) && (this.request != null) ) {
			html += "<div class='content'>";
			html = html + "<select id='" + selectID + "' name='" + selectID + "' class='dropdown' " + ((eventFunction != null) && (!"".equals(eventFunction.trim())) ? "onchange='" + eventFunction + "'" : " ") + ((width != null) && (!"".equals(width.trim())) ? "style='width:" + width + "'" : " ") + ">";
			html = html + getRBASelectOption(sqlID, code, initValue, firstComboWord, firstComboVal);
			html = html + "</select>";
			html = html + "</div>";
		}
		return html;
	}

	public String getRBASelectOption(String sqlID, String code, String initValue, String firstComboWord) {
		return getRBASelectOption(sqlID, code, initValue, firstComboWord, "");
	}

	public String getRBASelectOption(String sqlID, String code, String initValue, String firstComboWordParam, String firstComboVal) {
		String html = "";
		if ( (this.sessionAML != null) && (this.request != null) ) {
			String firstComboWord = firstComboWordParam;

			firstComboWord = getHelperMsg(firstComboWord, firstComboWord, new String[0]);
			if ( sqlID != null ) {
				html = html + setRBAComboHtml(sqlID, code, initValue, firstComboWord, firstComboVal);
			}
			else if ( code != null ) {
				html = html + commonUtil.setComboHtmlJspeed(sqlID, code, initValue, firstComboWord, firstComboVal);
			}
		}
		return html;
	}

	public static String setRBAComboHtml(String sqlID, String CODE_GROUP, String initValue, String firstComboWord, String firstComboVal) {
		DataObj output = new DataObj();
		StringBuffer sb = new StringBuffer(128);
		DataObj CD_Obj = new DataObj();
		try {
			if ( (firstComboWord != null) && (!"".equals(firstComboWord)) ) {
				sb.append("<option class='dropdown-option' value='");
				sb.append((firstComboVal == null ? "ALL" : firstComboVal));
				sb.append("' >::");
				sb.append(firstComboWord);
				sb.append("::</option> \n");
			}
			String[] condition = StringHelper.split(CODE_GROUP, ",");
			CD_Obj.put("CD", CODE_GROUP);

			if ( "".equals(CODE_GROUP) ) {
				condition = new String[0];
			}

			if ( "".equals(sqlID) ) {
				output = MDaoUtilSingle.getData("AML_00_00_00_00_common_getComboData_NCC92B", CD_Obj);
			} else {
				output = MDaoUtilSingle.getData(sqlID, CD_Obj);
			}

			String CODE = "";
			String NAME = "";

			if ( output.getCount("CODE") > 0 ) {
				for (int i = 0; i < output.getCount("CODE"); i++) {
					CODE = StringHelper.trim(StringHelper.nvl(output.getText("CODE", i), ""));
					NAME = StringHelper.nvl(output.getText("NAME", i), "");

					sb.append("<option class='dropdown-option' value='");
					sb.append(CODE);
					sb.append("' ");
					sb.append((initValue.equals(CODE) ? "selected" : ""));
					sb.append('>');
					sb.append(NAME);
					sb.append("</option> \n");
				}
			}

			return sb.toString();
		} catch (AMLException e) {
			Log.logAML(1, new commonUtil(), "setRBAComboHtml", e.getMessage());
		}
		return sb.toString();
	}

	public String getKRBASelect(String config) {
		if ( (config != null) && (!"".equals(config.trim())) ) {
			try {
				JSONObject json = toJSONObject(config);
				String msgID = json.optString("msgID");
				String defaultValue = json.optString("defaultValue");
				if ( !"".equals(msgID) ) {
					return getKRBASelect(msgID, defaultValue, json.optString("selectID"), json.optString("width"), json.optString("sqlID"), json.optString("code"), json.optString("initValue"), json.optString("firstComboWord"), json.optString("eventFunction"), json.optString("mapGroupCode"), json.optString("mapCode"), json.optString("defaultSelct"));
				}

				return getKRBASelect(json.optString("selectID"), json.optString("width"), json.optString("sqlID"), json.optString("code"), json.optString("initValue"), json.optString("firstComboWord"), json.optString("eventFunction"), json.optString("mapGroupCode"), json.optString("mapCode"), json.optString("defaultSelct"));
			} catch (JSONException localException) {
				Log.logAML(1, localException);
			} catch (Exception localException) {
				Log.logAML(1, localException);
			}
		}
		return "<script>alert('" + getHelperMsg("msg_common_00_023", "RBACondEL.getKRBASelect 의 컨피그레이션 값이 올바르지 않습니다.", new String[0]) + "');</script>";
	}

	public String getKRBASelect(String msgID, String defaultValue, String selectID, String width, String sqlID, String code, String initValue, String firstComboWord, String eventFunction, String mapGroupCode, String mapCode, String defaultSelct) {
		return getRBALabel(msgID, defaultValue) + getKRBASelect(selectID, width, sqlID, code, initValue, firstComboWord, eventFunction, mapGroupCode, mapCode, defaultSelct);
	}

	public String getKRBASelect(String selectID, String width, String sqlID, String code, String initValue, String firstComboWord, String eventFunction, String mapGroupCode, String mapCode, String defaultSelct) {
		String html = "";
		if ( (this.sessionAML != null) && (this.request != null) ) {
			html += "<div class='content'>";
			html = html + "<select id='" + selectID + "' name='" + selectID + "' groupCode='" + code + "' class='dropdown' " + ((eventFunction != null) && (!"".equals(eventFunction.trim())) ? "onchange='" + eventFunction + "'" : " ") + ((width != null) && (!"".equals(width.trim())) ? "style='width:" + width + "'" : " ") + ">";
			html = html + getKRBASelectOption(sqlID, code, initValue, firstComboWord, mapGroupCode, mapCode, defaultSelct);
			html = html + "</select>";
			html = html + "</div>";

		}
		return html;
	}

	public String getKRBASelect(String msgID, String defaultValue, String selectID, String width, String sqlID, String code, String initValue, String firstComboWord, String firstComboVal, String eventFunction, String mapGroupCode, String mapCode, String defaultSelct) {
		return getRBALabel(msgID, defaultValue) + getKRBASelect(selectID, width, sqlID, code, initValue, firstComboWord, firstComboVal, eventFunction, mapGroupCode, mapCode, defaultSelct);
	}

	public String getKRBASelect(String selectID, String width, String sqlID, String code, String initValue, String firstComboWord, String firstComboVal, String eventFunction, String mapGroupCode, String mapCode, String defaultSelct) {
		String html = "";
		if ( (this.sessionAML != null) && (this.request != null) ) {
			html += "<div class='content'>";
			html = html + "<select id='" + selectID + "' name='" + selectID + "' groupCode='" + code + "' class='dropdown' " + ((eventFunction != null) && (!"".equals(eventFunction.trim())) ? "onchange='" + eventFunction + "'" : " ") + ((width != null) && (!"".equals(width.trim())) ? "style='width:" + width + "'" : " ") + ">";
			html = html + getKRBASelectOption(sqlID, code, initValue, firstComboWord, firstComboVal, mapGroupCode, mapCode, defaultSelct);
			html = html + "</select>";
			html = html + "</div>";
		}
		return html;
	}

	public String getKRBASelectOption(String sqlID, String code, String initValue, String firstComboWord, String mapGroupCode, String mapCode, String defaultSelct) {
		return getKRBASelectOption(sqlID, code, initValue, firstComboWord, "", mapGroupCode, mapCode, defaultSelct);
	}

	public String getKRBASelectOption(String sqlID, String code, String initValue, String firstComboWordParam, String firstComboVal, String mapGroupCode, String mapCode, String defaultSelct) {
		String html = "";
		if ( (this.sessionAML != null) && (this.request != null) ) {
			String firstComboWord = firstComboWordParam;
			firstComboWord = getHelperMsg(firstComboWord, firstComboWord, new String[0]);
			if ( sqlID != null ) {
				html = html + setKRBAComboHtml(sqlID, code, initValue, firstComboWord, firstComboVal, mapGroupCode, mapCode, defaultSelct);
			}else if ( code != null ) {
				html = html + commonUtil.setComboHtmlJspeed(sqlID, code, initValue, firstComboWord, firstComboVal);
			}
		}
		return html;
	}

	public static String setKRBAComboHtml(String sqlID, String CODE_GROUP, String initValue, String firstComboWord, String firstComboVal, String mapGroupCode, String mapCode, String defaultSelct) {
		DataObj output = new DataObj();
		StringBuffer sb = new StringBuffer(128);
		HashMap param = new HashMap();
		DataObj CD_Obj = new DataObj();
		try {
			if ( (firstComboWord != null) && (!"".equals(firstComboWord)) ) {
				sb.append("<option class='dropdown-option' value='");
				sb.append((firstComboVal == null ? "ALL" : firstComboVal));
				sb.append("' >::");
				sb.append(firstComboWord);
				sb.append("::</option> \n");
			}

//			String[] condition = StringHelper.split(CODE_GROUP, ",");

			if ( "".equals(sqlID) ) {
				if ( (CODE_GROUP != null) && (!"".equals(CODE_GROUP)) ) {
					param.put("GRP_C", CODE_GROUP);
					CD_Obj.put("CD", CODE_GROUP);
				}
				if ( (mapGroupCode != null) && (!"".equals(mapGroupCode)) ) {
					param.put("HRNK_RBA_RSK_C", mapGroupCode);
				}
				if ( (mapCode != null) && (!"".equals(mapCode)) ) {
					param.put("HRNK_RBA_RSK_C_V", mapCode);
				}

				if ( "N".equals(defaultSelct) ) {
					param.put("GRP_C", "XXX");
					param.put("HRNK_RBA_RSK_C", "XXX");
					param.put("HRNK_RBA_RSK_C_V", "XXX");
					param.put("HGRK_DTL_C", "XXX");
				}

				if ( "CA".equals(CODE_GROUP) ) {
					output = MDaoUtilSingle.getData("RBA_common_getComboData_KRBA_RSK_CA", param);
				} else if ( "FA".equals(CODE_GROUP) ) {
					output = MDaoUtilSingle.getData("RBA_common_getComboData_KRBA_RSK_FA", param);
				} else if ( "EV".equals(CODE_GROUP) ) {
					output = MDaoUtilSingle.getData("RBA_common_getComboData_KRBA_RSK_EV", param);
				} else if ( "EV2".equals(CODE_GROUP) ) {
					output = MDaoUtilSingle.getData("RBA_common_getComboData_KRBA_RSK_EV2", param);
				} else if ( "P001".equals(CODE_GROUP) ) {
					output = MDaoUtilSingle.getData("RBA_common_getComboData_KRBA_RSK_CNTL2", param);
				} else if ( "CNTL_CATG1_C".equals(CODE_GROUP) ) {
					output = MDaoUtilSingle.getData("RBA_common_getComboData_KRBA_RSK_CNTL2", param);
				} else if ( "CNTL_CATG2_C".equals(CODE_GROUP) ) {
					output = MDaoUtilSingle.getData("RBA_common_getComboData_KRBA_RSK_CNTL2", param);
				} else if ( "SP001".equals(CODE_GROUP) ) {
					output = MDaoUtilSingle.getData("RBA_common_getComboData_SP001", param);
				} else if ( "SP003".equals(CODE_GROUP) ) {
					output = MDaoUtilSingle.getData("RBA_common_getComboData_SP003", param);
				} else if ( "EV_SARE".equals(CODE_GROUP) ) {
					output = MDaoUtilSingle.getData("RBA_common_getComboData_KRBA_RSK_EV_SARE", param);
				} else {
					output = MDaoUtilSingle.getData("RBA_common_getComboData_KRBA_DTL_C", param);
				}

			} else if ( !"".equals(sqlID) ) {
				output = MDaoUtilSingle.getData(sqlID, CD_Obj);

			} else {
				output = MDaoUtilSingle.getData("AML_00_00_00_00_common_getComboData_NCC92B", CD_Obj);
			}

			String CODE = "";
			String NAME = "";

			if ( output.getCount("CD") > 0 ) {
				for (int i = 0; i < output.getCount("CD"); i++) {
					CODE = StringHelper.trim(StringHelper.nvl(output.getText("CD", i), ""));
					NAME = StringHelper.nvl(output.getText("CD_NM", i), "");

					sb.append("<option class='dropdown-option' value='");
					sb.append(CODE);
					sb.append("' ");
					sb.append((initValue.equals(CODE) ? "selected" : ""));
					sb.append('>');
					sb.append(NAME);
					sb.append("</option> \n");
				}

			}

			return sb.toString();
		} catch (AMLException e) {
			Log.logAML(1, new commonUtil(), "setKRBAComboHtml", e.getMessage());
		} catch (Exception e) {
			Log.logAML(1, new commonUtil(), "setKRBAComboHtml", e.getMessage());
		}
		return sb.toString();
	}

	public String getPRBASelect(String config) {
		if ( (config != null) && (!"".equals(config.trim())) ) {
			try {
				JSONObject json = toJSONObject(config);
				String msgID = json.optString("msgID");
				String defaultValue = json.optString("defaultValue");
				if ( !"".equals(msgID) ) {
					return getPRBASelect(msgID, defaultValue, json.optString("selectID"), json.optString("width"), json.optString("sqlID"), json.optString("code"), json.optString("initValue"), json.optString("firstComboWord"), json.optString("eventFunction"), json.optString("mapGroupCode"), json.optString("mapCode"), json.optString("defaultSelct"));
				}

				return getPRBASelect(json.optString("selectID"), json.optString("width"), json.optString("sqlID"), json.optString("code"), json.optString("initValue"), json.optString("firstComboWord"), json.optString("eventFunction"), json.optString("mapGroupCode"), json.optString("mapCode"), json.optString("defaultSelct"));
			} catch (JSONException localException) {
				Log.logAML(Log.ERROR, localException);
			} catch (Exception localException) {
				Log.logAML(Log.ERROR, localException);
			}
		}

		return "<script>alert('" + getHelperMsg("msg_common_00_023", "RBACondEL.getPRBASelect 의 컨피그레이션 값이 올바르지 않습니다.", new String[0]) + "');</script>";
	}

	public String getPRBASelect(String msgID, String defaultValue, String selectID, String width, String sqlID, String code, String initValue, String firstComboWord, String eventFunction, String mapGroupCode, String mapCode, String defaultSelct) {
		return getRBALabel(msgID, defaultValue) + getPRBASelect(selectID, width, sqlID, code, initValue, firstComboWord, eventFunction, mapGroupCode, mapCode, defaultSelct);
	}

	public String getPRBASelect(String selectID, String width, String sqlID, String code, String initValue, String firstComboWord, String eventFunction, String mapGroupCode, String mapCode, String defaultSelct) {
		String html = "";
		if ( (this.sessionAML != null) && (this.request != null) ) {
			html = html + "<select id='" + selectID + "' name='" + selectID + "' groupCode='" + code + "' class='dropdown' " + ((eventFunction != null) && (!"".equals(eventFunction.trim())) ? "onchange='" + eventFunction + "'" : " ") + ((width != null) && (!"".equals(width.trim())) ? "style='width:" + width + "'" : " ") + ">";
			html = html + getPRBASelectOption(sqlID, code, initValue, firstComboWord, mapGroupCode, mapCode, defaultSelct);
			html = html + "</select>";
		}

		return html;
	}

	public String getPRBASelect(String msgID, String defaultValue, String selectID, String width, String sqlID, String code, String initValue, String firstComboWord, String firstComboVal, String eventFunction, String mapGroupCode, String mapCode, String defaultSelct) {
		return getRBALabel(msgID, defaultValue) + getPRBASelect(selectID, width, sqlID, code, initValue, firstComboWord, firstComboVal, eventFunction, mapGroupCode, mapCode, defaultSelct);
	}

	public String getPRBASelect(String selectID, String width, String sqlID, String code, String initValue, String firstComboWord, String firstComboVal, String eventFunction, String mapGroupCode, String mapCode, String defaultSelct) {
		String html = "";
		if ( (this.sessionAML != null) && (this.request != null) ) {
			html = html + "<select id='" + selectID + "' name='" + selectID + "' groupCode='" + code + "' class='dropdown' " + ((eventFunction != null) && (!"".equals(eventFunction.trim())) ? "onchange='" + eventFunction + "'" : " ") + ((width != null) && (!"".equals(width.trim())) ? "style='width:" + width + "'" : " ") + ">";
			html = html + getPRBASelectOption(sqlID, code, initValue, firstComboWord, firstComboVal, mapGroupCode, mapCode, defaultSelct);
			html = html + "</select>";
		}
		return html;
	}

	public String getPRBASelectOption(String sqlID, String code, String initValue, String firstComboWord, String mapGroupCode, String mapCode, String defaultSelct) {
		return getPRBASelectOption(sqlID, code, initValue, firstComboWord, "", mapGroupCode, mapCode, defaultSelct);
	}

	public String getPRBASelectOption(String sqlID, String code, String initValue, String firstComboWordParam, String firstComboVal, String mapGroupCode, String mapCode, String defaultSelct) {
		String html = "";
		if ( (this.sessionAML != null) && (this.request != null) ) {
			String firstComboWord = firstComboWordParam;
			firstComboWord = getHelperMsg(firstComboWord, firstComboWord, new String[0]);
			if ( sqlID != null ) {
				html = html + setPRBAComboHtml(sqlID, code, initValue, firstComboWord, firstComboVal, mapGroupCode, mapCode, defaultSelct);
			}
			else if ( code != null ) {
				html = html + commonUtil.setComboHtmlJspeed(sqlID, code, initValue, firstComboWord, firstComboVal);
			}
		}
		return html;
	}

	public static String setPRBAComboHtml(String sqlID, String CODE_GROUP, String initValue, String firstComboWord, String firstComboVal, String mapGroupCode, String mapCode, String defaultSelct) {
		DataObj output = new DataObj();
		StringBuffer sb = new StringBuffer();
		HashMap param = new HashMap();
		try {
			if ( (firstComboWord != null) && (!"".equals(firstComboWord)) ) {
				sb.append("<option value='").append((firstComboVal == null ? "ALL" : firstComboVal)).append("' >::").append(firstComboWord).append("::</option> \n");
			}

			String[] condition = StringHelper.split(CODE_GROUP, ",");

			if ( "".equals(sqlID) ) {
				if ( (CODE_GROUP != null) && (!"".equals(CODE_GROUP)) ) {
					param.put("GRP_C", CODE_GROUP);
				}
				if ( (mapGroupCode != null) && (!"".equals(mapGroupCode)) ) {
					param.put("HRNK_RBA_RSK_C", mapGroupCode);
				}
				if ( (mapCode != null) && (!"".equals(mapCode)) ) {
					param.put("HRNK_RBA_RSK_C_V", mapCode);
				}

				if ( "N".equals(defaultSelct) ) {
					param.put("GRP_C", "XXX");
					param.put("HRNK_RBA_RSK_C", "XXX");
					param.put("HRNK_RBA_RSK_C_V", "XXX");
					param.put("HGRK_DTL_C", "XXX");
				}

				if ( "CA".equals(CODE_GROUP) ) {
					output = MDaoUtilSingle.getData("RBA_common_getComboData_PRBA_RSK_CA", param);
				} else if ( "KI".equals(CODE_GROUP) ) {
					output = MDaoUtilSingle.getData("RBA_common_getComboData_PRBA_RSK_KI", param);
				} else if ( "FA".equals(CODE_GROUP) ) {
					output = MDaoUtilSingle.getData("RBA_common_getComboData_PRBA_RSK_FA", param);
				} else if ( "EV".equals(CODE_GROUP) ) {
					output = MDaoUtilSingle.getData("RBA_common_getComboData_PRBA_RSK_EV", param);
				} else if ( "EV2".equals(CODE_GROUP) ) {
					output = MDaoUtilSingle.getData("RBA_common_getComboData_PRBA_RSK_EV2", param);
				} else {
					output = MDaoUtilSingle.getData("RBA_common_getComboData_PRBA_DTL_C", param);
				}

			} else if ( !"".equals(sqlID) ) {
				output = MDaoUtilSingle.getData(sqlID, condition);

			} else {
				output = MDaoUtilSingle.getData("AML_00_00_00_00_common_getComboData_NCC92B", condition);
			}

			String CODE = "";
			String NAME = "";

			if ( output.getCount("CD") > 0 ) {
				for (int i = 0; i < output.getCount("CD"); i++) {
					CODE = StringHelper.trim(StringHelper.nvl(output.getText("CD", i), ""));
					NAME = StringHelper.nvl(output.getText("CD_NM", i), "");

					sb.append("<option value='").append(CODE).append("' ").append((initValue.equals(CODE) ? "selected" : "")).append('>').append(NAME).append("</option> \n");
				}

			}

			return sb.toString();
		} catch (AMLException e) {
			Log.logAML(1, new commonUtil(), "setPRBAComboHtml", e.getMessage());
		} catch (Exception e) {
			Log.logAML(1, new commonUtil(), "setPRBAComboHtml", e.getMessage());
		}
		return sb.toString();
	}

	public String getSRBA2Select(String config)
    {
        if (config!=null && !"".equals(config.trim())) {
                JSONObject json = toJSONObject(config);
                String msgID        = json.optString("msgID"       );
                String defaultValue = json.optString("defaultValue");
                if (!"".equals(msgID)) {
                    return getSRBA2Select(
                        msgID
                       ,defaultValue
                       ,json.optString("selectID"       )
                       ,json.optString("width"          )
                       ,json.optString("sqlID"          )
                       ,json.optString("code"           )
                       ,json.optString("initValue"      )
                       ,json.optString("firstComboWord" )
                       ,json.optString("eventFunction"  )
                       ,json.optString("mapGroupCode"  )
                       ,json.optString("mapCode"  )
                       ,json.optString("defaultSelct"  )
                    );
                } else {
                    return getSRBA2Select(
                        json.optString("selectID"       )
                       ,json.optString("width"          )
                       ,json.optString("sqlID"          )
                       ,json.optString("code"           )
                       ,json.optString("initValue"      )
                       ,json.optString("firstComboWord" )
                       ,json.optString("eventFunction"  )
                       ,json.optString("mapGroupCode"  )
                       ,json.optString("mapCode"  )
                       ,json.optString("defaultSelct"  )
                    );
                }
        }
        return "<script>alert('"+getHelperMsg("msg_common_00_023", "RBACondEL.getSRBA2Select 의 컨피그레이션 값이 올바르지 않습니다.")+"');</script>";
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
     * @param   eventFunction
     *              function onchang
     * @param   mapGroupCode
     *              mapGroupCode
     * @param   mapCode
     *              mapCode
     * @return  <code>String</code>
     *              <select><option/>...</select> 태그 html
     * @return  defaultSelct
     *              쿼리 Where절 해당 컬럼 XXX 초기셋팅
     */
    public String getSRBA2Select(
                      String msgID
                    , String defaultValue
                    , String selectID
                    , String width
                    , String sqlID
                    , String code
                    , String initValue
                    , String firstComboWord
                    , String eventFunction
                    , String mapGroupCode
                    , String mapCode
                    , String defaultSelct)
    { return getRBALabel(msgID, defaultValue) + getSRBA2Select(selectID, width, sqlID, code, initValue, firstComboWord, eventFunction, mapGroupCode, mapCode, defaultSelct ); }

    /**
     * sqlID의 쿼리로 조회 된 내용으로 <select> 및 <option> 엘리먼트를 생성하여 반환.
     * <p>
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
     * @param   eventFunction
     *              function onchang
     * @param   mapGroupCode
     *              mapGroupCode
     * @param   mapCode
     *              mapCode
     *
     * @return  <code>String</code>
     *              <select><option/>...</select> 태그 html
     * @return  defaultSelct
     *              쿼리 Where절 해당 컬럼 XXX 초기셋팅
     */
    public String getSRBA2Select(String selectID, String width, String sqlID, String code, String initValue, String firstComboWord, String eventFunction, String mapGroupCode , String mapCode, String defaultSelct)
    {

        String html = "";
        if (this.sessionAML!=null && this.request!=null) {
            html += "<select id='"+selectID+"' name='"+selectID+"' groupCode='"+code+"' class='dropdown' "+(eventFunction!=null&&!"".equals(eventFunction.trim())?"onchange='"+eventFunction+"'":" ")+(width!=null&&!"".equals(width.trim())?"style='width:"+width+"'":" ")+">";
            html += getSRBA2SelectOption(sqlID, code, initValue, firstComboWord, mapGroupCode, mapCode, defaultSelct);
            html += "</select>";
        }
        return html;
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
     * @param   eventFunction
     *              function onchang
     * @param   firstComboVal
     *              첫번째 콤보박스 값
     * @param   mapGroupCode
     *              mapGroupCode
     * @param   mapCode
     *              mapCode
     * @return  <code>String</code>
     *              <select><option/>...</select> 태그 html
     * @return  defaultSelct
     *              쿼리 Where절 해당 컬럼 XXX 초기셋팅
     */
    public String getSRBA2Select(String msgID, String defaultValue, String selectID, String width, String sqlID, String code, String initValue, String firstComboWord, String firstComboVal, String eventFunction, String mapGroupCode , String mapCode, String defaultSelct)
    { return getRBALabel(msgID, defaultValue) + getSRBA2Select(selectID, width, sqlID, code, initValue, firstComboWord, firstComboVal, eventFunction, mapGroupCode , mapCode , defaultSelct); }

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
     * @param   eventFunction
     *              function onchang
     * @param   firstComboWord
     *              첫번째 콤보박스 값
     * @param   mapGroupCode
     *              mapGroupCode
     * @param   mapCode
     *              mapCode
     * @return  <code>String</code>
     *              <select><option/>...</select> 태그 html
     * @return  defaultSelct
     *              쿼리 Where절 해당 컬럼 XXX 초기셋팅
     */
    public String getSRBA2Select(String selectID, String width, String sqlID, String code, String initValue, String firstComboWord, String firstComboVal, String eventFunction , String mapGroupCode , String mapCode, String defaultSelct)
    {

        String html = "";
        if (this.sessionAML!=null && this.request!=null) {
        html += "<select id='"+selectID+"' name='"+selectID+"' groupCode='"+code+"' class='dropdown' "+(eventFunction!=null&&!"".equals(eventFunction.trim())?"onchange='"+eventFunction+"'":" ")+(width!=null&&!"".equals(width.trim())?"style='width:"+width+"'":" ")+">";
        html += getSRBA2SelectOption(sqlID, code, initValue, firstComboWord, firstComboVal , mapGroupCode , mapCode , defaultSelct);
        html += "</select>";
    }
    return html; }

    /**
     * <div>로 감싸져 있는 검색조건의 레이블 및 <select> 와 <option> 엘리먼트를 생성하여 반환.
     * <p>
     * @param   configs
     *              파라미터를 포함하고 있는 JSON 형태의 스트링
     *                  msgID           : 메시지 키
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

    /**
     * sqlID의 쿼리로 조회 된 내용을 <option/> 태그로 변환하여 반환.
     * <p>
     * @param   sqlID
     *              쿼리 아이디
     *              아래의 code를 사용할 경우, sqlID는 "" 여야 한다
     * @param   code
     *              코드(NIC92B.CD)
     * @param   initValue
     *              초기값
     * @param   firstComboWord
     *              첫번째 콤보박스 단어(전체 or 선택 등등...)
     * @param   mapGroupCode
     *              mapGroupCode
     * @param   mapCode
     *              mapCode
     * @return  <code>String</code>
     *              <select><option/>...</select> 태그 html
     * @return  defaultSelct
     *              쿼리 Where절 해당 컬럼 XXX 초기셋팅
     */
    public String getSRBA2SelectOption(String sqlID, String code, String initValue, String firstComboWord, String mapGroupCode , String mapCode ,String defaultSelct)
    { return getSRBA2SelectOption(sqlID, code, initValue, firstComboWord, "", mapGroupCode , mapCode, defaultSelct); }

    /**
     * sqlID의 쿼리로 조회 된 내용을 <select/> 태그의 <option/> 태그로 변환하여 반환.
     * <p>
     * @param   sqlID
     *              쿼리 아이디
     *              아래의 code를 사용할 경우, sqlID는 "" 여야 한다
     * @param   code
     *              코드(NIC92B.CD)
     * @param   initValue
     *              초기값
     * @param   firstComboWord
     *              첫번째 콤보박스 단어(전체 or 선택 등등...)
     * @param   firstComboVal
     *              첫번째 콤보박스 값
     * @param   mapGroupCode
     *              mapGroupCode
     * @param   mapCode
     *              mapCode
     * @return  <code>String</code>
     *              <select><option/>...</select> 태그 html
     * @return  defaultSelct
     *              쿼리 Where절 해당 컬럼 XXX 초기셋팅
     */
    public String getSRBA2SelectOption(String sqlID, String code, String initValue, String firstComboWord, String firstComboVal, String mapGroupCode , String mapCode, String defaultSelct)
    {
        String html = "";
        if (this.sessionAML!=null && this.request!=null) {
            //String locale = Util.getLangCD(this.request.getLocale().toString());
            firstComboWord = getHelperMsg(firstComboWord, firstComboWord);
            if (sqlID!=null) {
                html += setSRBA2ComboHtml(sqlID, code, initValue, firstComboWord, firstComboVal, mapGroupCode , mapCode , defaultSelct);
            } else if (code!=null) {
                html += commonUtil.setComboHtmlJspeed(sqlID, code, initValue, firstComboWord, firstComboVal);
            }
        }
        return html;
    }

    @SuppressWarnings({ "rawtypes", "unchecked", "deprecation" })
    public static String setSRBA2ComboHtml(
            String sqlID
           ,String CODE_GROUP
           ,String initValue
           ,String firstComboWord
           ,String firstComboVal
           ,String mapGroupCode
           ,String mapCode
           ,String defaultSelct
  ){

//      @SuppressWarnings("unused")
//      DataObj input  = new DataObj();
      DataObj output = new DataObj();
      StringBuffer sb = new StringBuffer();
      HashMap param = new HashMap();
      DataObj CD_Obj = new DataObj();
      try{
          // 초값 설정 여부
          if(firstComboWord!=null && !"".equals(firstComboWord)) {
              sb.append("<option class='dropdown-option' value='" + (firstComboVal==null?"ALL":firstComboVal) +"' >::" + firstComboWord + "::</option> \n");
          }
/*        System.out.println("sqlID =" + sqlID);
          System.out.println("CODE_GROUP =" + CODE_GROUP);
          System.out.println("initValue =" + initValue);
          System.out.println("firstComboWord =" + firstComboWord);
          System.out.println("firstComboVal =" + firstComboVal);
          System.out.println("mapGroupCode =" + mapGroupCode);
          System.out.println("defaultSelct =" + defaultSelct);
*/
//          String[] condition = StringHelper.split(CODE_GROUP, ",");

          if ("".equals(sqlID)){
	          if(CODE_GROUP!=null && !"".equals(CODE_GROUP)){
		            param.put("GRP_C", CODE_GROUP);
					CD_Obj.put("CD", CODE_GROUP);
	          }

	            if ("N".equals(defaultSelct)) {
	            	param.put("GRP_C", "XXX");
				}

	            output = MDaoUtilSingle.getData("RBA_common_getComboData_SRBA2_DTL_C", param);


          }else if(!"".equals(sqlID)){
        	  output = MDaoUtilSingle.getData(sqlID, param);
          } else {
              output = MDaoUtilSingle.getData("AML_00_00_00_00_common_getComboData_NCC92B", CD_Obj);
          }

          String CODE = "";
          String NAME = "";

          if(output.getCount("CD") > 0){

              for(int i=0; i<output.getCount("CD"); i++){
                  CODE = StringHelper.trim(StringHelper.nvl(output.getText("CD",i), ""));
                  NAME = StringHelper.nvl(output.getText("CD_NM",i), "");

                  sb.append("<option class='dropdown-option' value='"+CODE+"' "+(initValue.equals(CODE) ? "selected":"")+">"+NAME+"</option> \n");

              }
          }

          return sb.toString();

      }catch(AMLException e){
          Log.logAML(
                   Log.ERROR
                  , new commonUtil()
                  ,"setSRBA2ComboHtml"
                  ,e.getMessage()
          );
          return sb.toString();
      }
  }

	public static void setup(PageContext pageContext) {
		setup("RBACondEL", pageContext, RBACondEL.class);
	}
}