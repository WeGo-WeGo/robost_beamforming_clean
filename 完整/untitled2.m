%% ------------------------------
% 合併多使用者 H_HAT 範例程式（檔名 H_HAT_INF_userX）
%% ------------------------------

% 設定使用者數量
nUsers = 2;

% 自動抓桌面路徑
desktopPath = fullfile(getenv('USERPROFILE'), 'Desktop');

% 初始化 cell 儲存 H_HAT
H_cell = cell(1, nUsers);

% 讀取每個使用者的 H_HAT
for k = 1:nUsers
    filename = fullfile(desktopPath, ['H_HAT_INF_user' num2str(k) '.mat']);
    if exist(filename, 'file')
        load(filename, 'H_HAT');
        H_cell{k} = H_HAT;  % 暫存
    else
        error(['File not found: ' filename]);
    end
end

% 擴展維度並合併成 [MC, nUsers, nrx, ntx]
MC = size(H_cell{1},1);
nrx = size(H_cell{1},2);
ntx = size(H_cell{1},3);

H_combined = zeros(MC, nUsers, nrx, ntx);

for k = 1:nUsers
    H_combined(:,k,:,:) = reshape(H_cell{k}, [MC, 1, nrx, ntx]);
end

% 檢查大小
disp('Size of H_combined:');
disp(size(H_combined));  % 應顯示 [MC, nUsers, nrx, ntx]

% 存檔
save(fullfile(desktopPath, 'H_HAT_INF_combined.mat'), 'H_combined');

disp(['H_HAT_combined saved to Desktop: ', fullfile(desktopPath, 'H_HAT_INF_combined.mat')]);
