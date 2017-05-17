package br.ufpe.cin.app;

import java.io.File;

public class S3mBatch {
	
	private String revisionsPath;
	private JFSTMerge merger;
	
	public S3mBatch(String revisionsPath) {
		this.revisionsPath = revisionsPath;
		merger = new JFSTMerge();
	}
	
	public void runS3m() {
		File revisionsDirectory = new File(revisionsPath);
		
		File[] revisions = revisionsDirectory.listFiles();
		
		for (int i = 0; i < revisions.length; i++) {
			File revision = revisions[i];
			File[] revisionFolderContent = revision.listFiles();
			
			for (int j = 0; j < revisionFolderContent.length; j++) {
				if(revisionFolderContent[j].isFile()) {
					File revisionFile = revisionFolderContent[j];
					
					merger.mergeRevisions(revisionFile.getAbsolutePath());
					
					break;
				}
			}
		}
		
	}
}
