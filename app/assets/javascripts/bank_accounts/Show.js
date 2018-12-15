var Show = (function () {
   var $btnNewTransaction;
   var $modalTransaction;
   var $btnSave;
   var $inputAmount;
   var $selectTransactionType;
   var $parameters;
   var $notification;

   var bankAccountId;
   var url = "/api/version1/bank_accounts/new_transaction";

   var fetchElements = function () {
     $btnNewTransaction = $("#btn-new-transaction");
     $modalTransaction = $("#modal-transaction");
     $btnSave = $("#btn-save");
     $inputAmount = $("#input-amount");
     $selectTransactionType = $("#select-transaction-type");
     $notification = $(".notification");
     $parameters = $("#parameters");

     bankAccountId = $("#parameters").data("bank-account-id");
   };

   var disableControls = function () {
     $btnSave.prop("disabled", true);
     $inputAmount.prop("disabled", true);
     $selectTransactionType.prop("disabled", true)
   };

   var enableControls = function () {
     $btnSave.prop("disabled", false);
     $inputAmount.prop("disabled", false);
     $selectTransactionType.prop("disabled", false);
   };

   var initializeEvents = function () {
     $btnNewTransaction.on("click", function () {
         $modalTransaction.modal("show");
     });

     $btnSave.on("click", function () {
        var amount = $inputAmount.val();
        var transactionType = $selectTransactionType.val();
        disableControls();

        console.log("Amount: " + amount + " Transaction Type " + transactionType + " Bank Account ID: " + bankAccountId);

        $notification.html("");

        $.ajax({
            url: url,
            method: 'POST',
            dataType: 'json',
            data: {
                amount: amount,
                transaction_type: transactionType,
                bank_account_id: bankAccountId
            },
            success: function (response) {
                window.location.href = "/bank_accounts/" + bankAccountId;
            },
            error: function (response) {
                $notification.html(JSON.parse(response.responseText).errors.join());
                enableControls();
            }
        });
     });
   };

   var init = function () {
     fetchElements();
     initializeEvents();
   };

   return {
       init: init
   };
})();