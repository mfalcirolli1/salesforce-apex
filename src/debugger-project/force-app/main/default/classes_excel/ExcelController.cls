public with sharing class ExcelController {

    @AuraEnabled
    public static void readExcelFile(String data) {

        List<ExcelModel> records = (List<ExcelModel>) JSON.deserialize(data, List<ExcelModel>.class);
        List<Account> customObjectRecords = new List<Account>();

        for (ExcelModel record : records) {
            
            Account obj = new Account();
            obj.Name = record.Name;
            obj.Phone = record.Phone;

            customObjectRecords.add(obj);
            System.debug('Registro: ' + obj);
        }

        if (!customObjectRecords.isEmpty()) {
            //insert customObjectRecords;
            System.debug('Objetos inseridos');
        }
    }
}