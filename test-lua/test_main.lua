----------------------------------------------------------------------------------------------------
--  IFComicDownload��lua�ű����ز��Թ��� ver 1.0
--  2016-9-14 06:03:46 by seedjyh@gmail.com
----------------------------------------------------------------------------------------------------
-- ���ļ��ǲ���lua�ű������ļ���
-- ����4����
-- 1. ����script/api/lua�ű����Լ�script/sites/www.XXX.com/*.lua�������ĸ�վ����Ҫָ�����ű���
-- 2. ��ȡһ��ָ����html�ļ�����������������ص����أ���
-- 3. ������Ҫ���Եĺ�������ֹһ����������Analyse��Get���������
----------------------------------------------------------------------------------------------------

-- Step 1���������д����Ի����ʱ���õ���lua�ű���
-- Step 1.1�����ز��Թ��ߺ���
dofile("M:\\GitHubRepositories\\IFComicDownloader\\test-lua\\test_tool.lua")
-- Step 1.2�����ش����ԵĽű�
LoadLuaFileList(GetAllLuaFilesInPath("M:\\GitHubRepositories\\IFComicDownloader\\script\\api\\"))
LoadLuaFileList(GetAllLuaFilesInPath("M:\\GitHubRepositories\\IFComicDownloader\\script\\sites\\www.mh160.com\\"))
-- Step 1.3������table: test_case_list
dofile("M:\\GitHubRepositories\\IFComicDownloader\\test-lua\\www.mh160.com\\profile.lua")

-- Step 2��ִ�в���
for case_name, case_data in pairs(test_case_list) do
    print('Starting test case: ' .. case_name)
    local analyse_result = case_data.function_to_test(case_data.url, ReadFile(case_data.page), "")
    print('expected:')
    print(ReadFile(case_data.expected_analyse_result))
    print('actual:')
    print(analyse_result)
end
pagestr = ReadFile(web_file_path)

-- END.

-- ע����Analyse�׶β������κ�ת�롣
-- ��Ϊת����Ҫ����C�⣬��Ŀǰ��û�п���lua�����뿪C���������C��Ĵ��롣
-- ת�����ڴӷ������Get���ݵ�ʱ���ǲ�����ʱ�����ԡ�
-- ��������������жϡ�