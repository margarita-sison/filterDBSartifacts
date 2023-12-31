% Script generated by Brainstorm (03-Dec-2023)

% === RUNNING SCRIPT ON RAMEN ===

% Start Brainstorm
cd /home/msison/Documents/brainstorm3;
if ~brainstorm('status')
    brainstorm server
end

ProtocolName = 'ber009_stimoff';

% Path to a Brainstorm database (= a folder that contains one or more Brainstorm protocols)
BrainstormDbDir = '/home/msison/Documents/brainstorm_db';
bst_set('BrainstormDbDir', BrainstormDbDir);

iProtocol = bst_get('Protocol', ProtocolName);
if ~isempty(iProtocol)
    gui_brainstorm('DeleteProtocol', ProtocolName);
end

gui_brainstorm('CreateProtocol', ProtocolName, 1, 1);

% ===============================

% Input files
sFiles = {...
    '/home/msison/ber009_StimOFF_rest_run-01.con'};

% Start a new report
bst_report('Start', sFiles);

% Process: Power spectrum density (Welch)
sFiles = bst_process('CallProcess', 'process_psd', sFiles, [], ...
    'timewindow',  [0, 349.9998], ...
    'win_length',  1, ...
    'win_overlap', 50, ...
    'units',       'physical', ...  % Physical: U2/Hz
    'sensortypes', 'MEG', ...
    'win_std',     0, ...
    'edit',        struct(...
         'Comment',         'Power', ...
         'TimeBands',       [], ...
         'Freqs',           [], ...
         'ClusterFuncTime', 'none', ...
         'Measure',         'power', ...
         'Output',          'all', ...
         'SaveKernel',      0));

% Process: Send report by email
sFiles = bst_process('CallProcess', 'process_report_email', sFiles, [], ...
    'username',   'margaritasison', ...
    'cc',         'margarita.sison@charite.de', ...
    'subject',    'Process completed', ...
    'reportfile', 'current', ...
    'full',       1);

% Save and display report
ReportFile = bst_report('Save', sFiles);
% bst_report('Open', ReportFile);
% bst_report('Export', ReportFile, ExportDir);
% bst_report('Email', ReportFile, username, to, subject, isFullReport);

% Delete temporary files
% gui_brainstorm('EmptyTempFolder');

