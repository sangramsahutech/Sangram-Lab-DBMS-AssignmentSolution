CREATE DEFINER=`root`@`localhost` PROCEDURE `RATE_SUPPLIERS`()
BEGIN
	select s.supp_id, s.supp_name, r.rat_ratstars, 
	case 
		when r.rat_ratstars>4 then "Genuine Suppliers"
		when r.rat_ratstars>2 then "Average suppliers"
		else 
			"Supplier should not be considered"
	end as verdict
	 from supplier s join rating r ON r.supp_id=s.supp_id;
END