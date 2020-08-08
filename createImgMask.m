%% Interactively obtain the ROI of your image repair part
imds = imageDatastore('./yourImgFolder');
for i = 1:length(imds.Files)
    [~,name,~] = fileparts(imds.Files{i});
    img = readimage(imds,i);
    f = imshow(img);
    
    maskAll = zeros(size(img));
    while isvalid(f) % close figure
        roi = drawfreehand(gca,'Color','r','Multiclick',true,'Selected',true);
        if ~isvalid(roi)
            break;
        end
        mask = createMask(roi);
        maskAll = maskAll | mask;
    end
    imwrite(maskAll,['mask/',name,'.jpg']);
end
