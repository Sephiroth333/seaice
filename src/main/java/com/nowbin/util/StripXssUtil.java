package com.nowbin.util;

import java.util.regex.Pattern;


public class StripXssUtil {


	private static String xssEncode(String s) {
		if (s == null || s.isEmpty()) {
			return s;
		}
		
		StringBuilder sb = new StringBuilder(s.length() + 16);
		for (int i = 0; i < s.length(); i++) {
			char c = s.charAt(i);
			switch (c) {
			case '>':
				sb.append('＞');//全角大于号
				break;
			case '<':
				sb.append('＜');//全角小于号
				break;
			case '\'':
				sb.append('‘');//全角单引号
				break;
			case '\"':
				sb.append('“');//全角双引号
				break;
			case '&':
				sb.append('＆');//全角
				break;
			case '\\':
				sb.append('＼');//全角斜线
				break;
			case '#':
				sb.append('＃');//全角井号
				break;
			default:
				sb.append(c);
				break;
			}
		}
		return sb.toString();
	}	

	/**
	 * 
	 * 过滤Xss攻击工具类
	 * @param value
	 * @return
	 */
	public static String stripXSS(String value) {
		if (value != null) {
			
			value = value.replaceAll("", "");

			Pattern scriptPattern = Pattern.compile("<script>(.*?)</script>",
					Pattern.CASE_INSENSITIVE);
			value = scriptPattern.matcher(value).replaceAll("");

			scriptPattern = Pattern.compile("src[\r\n]*=[\r\n]*\\\'(.*?)\\\'",
					Pattern.CASE_INSENSITIVE | Pattern.MULTILINE
					| Pattern.DOTALL);
			value = scriptPattern.matcher(value).replaceAll("");
			scriptPattern = Pattern.compile("src[\r\n]*=[\r\n]*\\\"(.*?)\\\"",
					Pattern.CASE_INSENSITIVE | Pattern.MULTILINE
					| Pattern.DOTALL);
			value = scriptPattern.matcher(value).replaceAll("");

			scriptPattern = Pattern.compile("</script>",
					Pattern.CASE_INSENSITIVE);
			value = scriptPattern.matcher(value).replaceAll("");

			scriptPattern = Pattern.compile("<script(.*?)>",
					Pattern.CASE_INSENSITIVE | Pattern.MULTILINE
					| Pattern.DOTALL);
			value = scriptPattern.matcher(value).replaceAll("");

			scriptPattern = Pattern.compile("eval\\((.*?)\\)",
					Pattern.CASE_INSENSITIVE | Pattern.MULTILINE
					| Pattern.DOTALL);
			value = scriptPattern.matcher(value).replaceAll("");

			scriptPattern = Pattern.compile("e­xpression\\((.*?)\\)",
					Pattern.CASE_INSENSITIVE | Pattern.MULTILINE
					| Pattern.DOTALL);
			value = scriptPattern.matcher(value).replaceAll("");

			scriptPattern = Pattern.compile("javascript:",
					Pattern.CASE_INSENSITIVE);
			value = scriptPattern.matcher(value).replaceAll("");

			scriptPattern = Pattern.compile("vbscript:",
					Pattern.CASE_INSENSITIVE);
			value = scriptPattern.matcher(value).replaceAll("");

			scriptPattern = Pattern.compile("onload(.*?)=",
					Pattern.CASE_INSENSITIVE | Pattern.MULTILINE
					| Pattern.DOTALL);
			value = scriptPattern.matcher(value).replaceAll("");
		}
		value = xssEncode(value);
		return value;
	}
}
