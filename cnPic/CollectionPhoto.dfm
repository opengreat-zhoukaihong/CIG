�
 TFMCOLLECTIONPHOTO 0�  TPF0TfmCollectionPhotofmCollectionPhotoLeft%�Top.Width�Height"Caption������Ʒ��ͼƬ����Color	clBtnFaceFont.CharsetGB2312_CHARSET
Font.ColorclWindowTextFont.Height�	Font.Name����
Font.Style OldCreateOrderPositionpoDesktopCenterOnClose	FormCloseOnCreate
FormCreatePixelsPerInch`
TextHeight TPanelPanel3Left Top Width�HeightAlignalTopFont.CharsetGB2312_CHARSET
Font.ColorclWindowTextFont.Height�	Font.Name����
Font.StylefsBold 
ParentFontTabOrder  TLabelLabel3LeftTopWidth;HeightCaption��Ʒ��: Font.CharsetGB2312_CHARSET
Font.ColorclWindowTextFont.Height�	Font.Name����
Font.StylefsBold 
ParentFont  TDBTextDBText1Left@TopWidthAHeight	DataFieldNAME
DataSourcedmPic.dsCollectionFont.CharsetGB2312_CHARSET
Font.ColorclWindowTextFont.Height�	Font.Name����
Font.StylefsBold 
ParentFont  TDBNavigatorDBNavigator1Left� TopWidth� Height
DataSourcedmPic.dsCollectionPhotoVisibleButtonsnbFirstnbPriornbNextnbLastnbInsertnbDeletenbEditnbPostnbCancel AlignalRightConfirmDeleteTabOrder    	TwwDBGrid	wwDBGrid2Left TopWidth�Height� Selected.StringsPHOTOID	22	ͼƬ���PhotoName	31	ͼƬ����VERIFY_FLAG	4	ȷ�� 
TitleColor	clBtnFace	FixedCols ShowHorzScrollBar	AlignalClient
DataSourcedmPic.dsCollectionPhotoTabOrderTitleAlignmenttaCenterTitleFont.CharsetGB2312_CHARSETTitleFont.ColorclWindowTextTitleFont.Height�TitleFont.Name����TitleFont.Style 
TitleLinesTitleButtonsIndicatorColoricBlack  TwwDBLookupCombodlcPhotoLeftxTop`WidthyHeightDropDownAlignmenttaLeftJustifySelected.StringsPHOTOID	6	ͼƬ���	FNAME	10	ͼƬ����	FPLACE	10	����ص�	FTIME	10	����ʱ��	FIMAGEFILE	20	ͼƬ�ļ�	F LookupTable
quSelPhotoLookupFieldPHOTOIDOptions
loColLines
loRowLinesloTitles TabOrderAutoDropDown
ShowButton	AllowClearKey  TwwQuery
quSelPhotoActive	DatabaseNamedbPic
DataSourcedmPic.dsAuthorSQL.StringsEselect * from local_photo where AuthorId = :AuthorID order by PhotoID ValidateWithMask	Left� Top� 	ParamDataDataTypeftBCDNameAUTHORID	ParamType	ptUnknown   	TBCDFieldquSelPhotoPHOTOIDDisplayLabelͼƬ���DisplayWidth	FieldNamePHOTOIDOriginLOCAL_PHOTO.PHOTOID	Precision Size   TStringFieldquSelPhotoNAMEDisplayLabelͼƬ����DisplayWidth
	FieldNameNAMEOriginLOCAL_PHOTO.NAMESized  TStringFieldquSelPhotoPLACEDisplayLabel����ص�DisplayWidth
	FieldNamePLACEOriginLOCAL_PHOTO.PLACESized  TDateTimeFieldquSelPhotoTIMEDisplayLabel����ʱ��DisplayWidth
	FieldNameTIMEOriginLOCAL_PHOTO.TIME  TStringFieldquSelPhotoIMAGEFILEDisplayLabelͼƬ�ļ�DisplayWidth	FieldName	IMAGEFILEOriginLOCAL_PHOTO.IMAGEFILESize2  	TBCDFieldquSelPhotoAUTHORID	FieldNameAUTHORIDOriginLOCAL_PHOTO.AUTHORIDVisible	Precision Size   TStringFieldquSelPhotoDESCRIPTION	FieldNameDESCRIPTIONOriginLOCAL_PHOTO.DESCRIPTIONVisibleSize�   TStringFieldquSelPhotoLOCATION	FieldNameLOCATIONOriginLOCAL_PHOTO.LOCATIONVisible  TStringFieldquSelPhotoCONTENT	FieldNameCONTENTOriginLOCAL_PHOTO.CONTENTVisibleSized  TStringFieldquSelPhotoSTORAGEID	FieldName	STORAGEIDOriginLOCAL_PHOTO.STORAGEIDVisibleSize2  TStringFieldquSelPhotoMANUSCRIPT	FieldName
MANUSCRIPTOriginLOCAL_PHOTO.MANUSCRIPTVisibleSize  	TBCDFieldquSelPhotoMANUSCRIPTID	FieldNameMANUSCRIPTIDOriginLOCAL_PHOTO.MANUSCRIPTIDVisible	Precision Size   	TBCDFieldquSelPhotoFILE_SIZE	FieldName	FILE_SIZEOriginLOCAL_PHOTO.FILE_SIZEVisible	PrecisionSize   TStringFieldquSelPhotoFILE_FORMAT	FieldNameFILE_FORMATOriginLOCAL_PHOTO.FILE_FORMATVisibleSize  TStringFieldquSelPhotoFILMTYPE	FieldNameFILMTYPEOriginLOCAL_PHOTO.FILMTYPEVisibleSize2  	TBCDFieldquSelPhotoDIRID	FieldNameDIRIDOriginLOCAL_PHOTO.DIRIDVisible	Precision Size   TStringFieldquSelPhotoTHUMBFILE	FieldName	THUMBFILEOriginLOCAL_PHOTO.THUMBFILEVisibleSize2  TStringFieldquSelPhotoSMALLFILE	FieldName	SMALLFILEOriginLOCAL_PHOTO.SMALLFILEVisibleSize2  TStringFieldquSelPhotoMIDDLEFILE	FieldName
MIDDLEFILEOriginLOCAL_PHOTO.MIDDLEFILEVisibleSize2  	TBCDFieldquSelPhotoFULLPRICE1	FieldName
FULLPRICE1OriginLOCAL_PHOTO.FULLPRICE1Visible	Precision Size   	TBCDFieldquSelPhotoCOMMERCIALPRICE1	FieldNameCOMMERCIALPRICE1OriginLOCAL_PHOTO.COMMERCIALPRICE1Visible	Precision Size   	TBCDFieldquSelPhotoNOCOMPRICE1	FieldNameNOCOMPRICE1OriginLOCAL_PHOTO.NOCOMPRICE1Visible	Precision Size   	TBCDFieldquSelPhotoMAGAZINEPRICE1	FieldNameMAGAZINEPRICE1OriginLOCAL_PHOTO.MAGAZINEPRICE1Visible	Precision Size   TStringFieldquSelPhotoCURRENCY1	FieldName	CURRENCY1OriginLOCAL_PHOTO.CURRENCY1VisibleSize
  TStringFieldquSelPhotoREMARK	FieldNameREMARKOriginLOCAL_PHOTO.REMARKVisibleSize�   TStringFieldquSelPhotoSTATUS	FieldNameSTATUSOriginLOCAL_PHOTO.STATUSVisibleSize  TStringFieldquSelPhotoVERIFY_FLAG1	FieldNameVERIFY_FLAG1OriginLOCAL_PHOTO.VERIFY_FLAG1VisibleSize  TStringFieldquSelPhotoVERIFY_FLAG2	FieldNameVERIFY_FLAG2OriginLOCAL_PHOTO.VERIFY_FLAG2VisibleSize  TStringFieldquSelPhotoRECORDSTATUS	FieldNameRECORDSTATUSOriginLOCAL_PHOTO.RECORDSTATUSVisibleSize  TDateTimeFieldquSelPhotoCREATEDATE	FieldName
CREATEDATEOriginLOCAL_PHOTO.CREATEDATEVisible  TDateTimeFieldquSelPhotoLASTMODIFYDATE	FieldNameLASTMODIFYDATEOriginLOCAL_PHOTO.LASTMODIFYDATEVisible    