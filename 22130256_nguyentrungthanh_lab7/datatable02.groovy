import static com.kms.katalon.core.checkpoint.CheckpointFactory.findCheckpoint
import static com.kms.katalon.core.testcase.TestCaseFactory.findTestCase
import static com.kms.katalon.core.testdata.TestDataFactory.findTestData
import static com.kms.katalon.core.testobject.ObjectRepository.findTestObject
import static com.kms.katalon.core.testobject.ObjectRepository.findWindowsObject
import com.kms.katalon.core.checkpoint.Checkpoint as Checkpoint
import com.kms.katalon.core.cucumber.keyword.CucumberBuiltinKeywords as CucumberKW
import com.kms.katalon.core.mobile.keyword.MobileBuiltInKeywords as Mobile
import com.kms.katalon.core.model.FailureHandling as FailureHandling
import com.kms.katalon.core.testcase.TestCase as TestCase
import com.kms.katalon.core.testdata.TestData as TestData
import com.kms.katalon.core.testng.keyword.TestNGBuiltinKeywords as TestNGKW
import com.kms.katalon.core.testobject.TestObject as TestObject
import com.kms.katalon.core.webservice.keyword.WSBuiltInKeywords as WS
import com.kms.katalon.core.webui.keyword.WebUiBuiltInKeywords as WebUI
import com.kms.katalon.core.windows.keyword.WindowsBuiltinKeywords as Windows
import internal.GlobalVariable as GlobalVariable
import org.openqa.selenium.Keys as Keys

WebUI.openBrowser('')

WebUI.navigateToUrl('https://hypershop-scys.onrender.com/admin/manage-cart')

WebUI.setText(findTestObject('Object Repository/datatable/Page_HyperS/input_We will provide the best shose for yo_de99d5'), 
    '010203040506')

WebUI.setEncryptedText(findTestObject('Object Repository/datatable/Page_HyperS/input_We will provide the best shose for yo_de99d5_1'), 
    'aeHFOx8jV/A=')

WebUI.click(findTestObject('Object Repository/datatable/Page_HyperS/div_LOGIN'))

WebUI.click(findTestObject('Object Repository/datatable/Page_HyperS/span_Quay li'))

WebUI.click(findTestObject('Object Repository/datatable/Page_HyperS/div_Qun l banner'))

WebUI.click(findTestObject('Object Repository/datatable/Page_HyperS/input_ang c s dng_k-checkbox k-checkbox-md _836beb'))

WebUI.click(findTestObject('Object Repository/datatable/Page_HyperS/input_ang c s dng_k-checkbox k-checkbox-md _836beb'))

WebUI.click(findTestObject('Object Repository/datatable/Page_HyperS/input_Ngng hot ng_k-checkbox k-checkbox-md _87b61a'))

WebUI.click(findTestObject('Object Repository/datatable/Page_HyperS/input_Ngng hot ng_k-checkbox k-checkbox-md _87b61a'))

WebUI.click(findTestObject('Object Repository/datatable/Page_HyperS/div_Xa b lc'))

WebUI.closeBrowser()

