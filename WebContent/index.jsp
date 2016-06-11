<!DOCTYPE html>
<html>
<head>
	<title>Kwanzoo</title>
	<meta name="viewport" content="width=device-width, initial-scale=1">

	<!-- stylesheets -->
	<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
	<style type="text/css">
	.jumbotron{
		background: #FFF;
	}
	</style>

	<!-- javascripts -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>
	<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.6.0/js/bootstrap-datepicker.min.js"></script>
	<script src="http://ajax.googleapis.com/ajax/libs/angularjs/1.4.8/angular.min.js"></script>
	<script src="http://ajax.googleapis.com/ajax/libs/angularjs/1.4.8/angular-messages.min.js"></script>
	

	<script type='text/javascript' src='/Statistics/dwr/engine.js'></script>
	<script type='text/javascript' src='/Statistics/dwr/interface/Demo.js'></script>
	<script type='text/javascript' src='/Statistics/dwr/util.js'></script>

</head>
<body>

	<div class="container">
		<h1>Kwanzoo</h2>
		<br>
		<div ng-app="kwanzooApp" ng-controller="kwanzooController">
			<div class="row">
				<form class="form-inline">
				
					<div class="col-sm-3">
						<div class="form-group">
				      		<label for="query">Name:</label>	
							<input class="form-control" type="text" id="query" ng-model="query" required/>
							<div ng-messages="exampleForm.userFirstName.$error"></div>
						</div>
				    </div>
				    
				    <div class="col-sm-1">
				      	<button class="btn btn-primary" ng-click="search()">Search</button>
				    </div>
				    
				    <div class="col-sm-1">
				      	<!--select to load username serached by search request -->
						<div class="dropdown form-group">
							<button class="btn btn-primary dropdown-toggle" type="button" data-toggle="dropdown">
							{{currUser}}
							<span class="caret"></span></button>
							<ul class="dropdown-menu" id="user_dropdown">
							    <li ng-repeat="user in users"><a ng-click="selectedIndex(user.user_id, user.username)">{{user.username}}</a></li>
						  	</ul>
						</div>
				    </div>
				    
				    <div class="col-sm-6">
				      	<!-- from and to date pickers -->
						<label for="form_date"> From:</label>
		                <div class="input-group date" id="from_date">
		                    <input type="text" class="form-control" ng-model="fromDate" id="fromDate" required/>
		                    <div ng-messages="exampleForm.userFirstName.$error"></div>
		                    <span class="input-group-addon">
		                        <span class="glyphicon glyphicon-calendar"></span>
		                    </span>
		                </div>
		             
		                <label for="to_date"> To:</label>
		                <div class="input-group date" id="to_date">
		                    <input type="text" class="form-control"  id="toDate" ng-model="toDate" required/>
		                    <div ng-messages="exampleForm.userFirstName.$error"></div>
		                    <span class="input-group-addon">
		                        <span class="glyphicon glyphicon-calendar"></span>
		                    </span>
		                </div>
				    </div>
				    
				    <div class="col-sm-1">
				      <button class="btn btn-primary" ng-disabled="form.$invalid || isUserSelected() " ng-click="fetch()">Fetch</button>
				    </div>
				    
				</form>
			</div>
			<br>
			<br>
			<div class="row">
				<table class="table table-hover table-bordered table-striped">
					<tr>
						<th class="col-sm-4">ID</th>
						<th class="col-sm-4">Name</th>
						<th class="col-sm-4">Count</th>
					</tr>
					<tr ng-repeat="entry in entries">
						<td class="col-sm-4">{{entry[0]}}</td>
						<td class="col-sm-4">{{entry[1]}}</td>
						<td class="col-sm-4">{{entry[2]}}</td>
					</tr>					
				</table>
			</div>
		</div><!-- app close -->
	</div> 

<script type="text/javascript">

	//set initial date difference 3 months
	$(function () {
		var fromDate = new Date();
		fromDate.setMonth(fromDate.getMonth()-3);
        $("#from_date").datepicker({format:"yyyy-mm-dd"}).datepicker("setDate", fromDate);
        $("#to_date").datepicker({format:"yyyy-mm-dd"}).datepicker("setDate", new Date());

    });

    angular.module('kwanzooApp', []).controller('kwanzooController', function($scope, $http){

    	$scope.users = [];
    	$scope.entries = []; 
    	$scope.currUser = "Select";
    	$scope.fromDate = $("#fromDate").val();
    	$scope.toDate = $("#toDate").val();
    	

    	//selcted Index
    	$scope.selectedIndex = function(id, name){
    		$scope.currUser = name;
    		$scope.selectedUserId = id;
    	};
    	
    	//search user based on query
    	$scope.search = function(){
    		 console.log("searching users...");
			 if($scope.query != null){
				 Demo.getUsers($scope.query, function(data) { 
		  			$scope.users = [];
		  		 	data.forEach(function(entry){
		  		 		$scope.users.push(entry);
		  		 	});
		  		 	$scope.$apply();
		  		 });
			 }
			 $scope.currUser = "Select";
    	};

    	//fetch information based on 
    	$scope.fetch = function(){	
    		
    		console.log($scope.selectedUserId);
    		console.log($scope.fromDate);
    		console.log($("#fromDate").val());
    		
    		if($scope.selectedUserId != null && $("#fromDate").val() != null && $("#toDate").val() != null){
	    		 Demo.getReport($scope.selectedUserId,$("#fromDate").val(), $("#toDate").val(), function(data) {
	    			 $scope.entries = [];
	     		 	data.forEach(function(entry){
	     		 		$scope.entries.push(entry);
	     		 	});
	     		 	$scope.$apply();
	     		 	console.log($scope.entries);
	     		 });
    		}
    	};
    	
    	$scope.isUserSelected=function(){
    		if($scope.selectedUserId==null){
    			return true;
    		}else{
    			return false;
    		}
    	}


    });
    	
</script>

</body>
</html>