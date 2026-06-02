package com.bggchef.util;

import java.io.File;
import java.util.UUID;

/** 파일 업로드 유틸 */
public class FileUtil {

    /** 원본 파일명을 보존하면서 UUID prefix로 고유한 파일명 생성 */
    public static String generateUniqueFileName(String originalName) {
        String ext = "";
        int dotIdx = (originalName != null) ? originalName.lastIndexOf('.') : -1;
        if (dotIdx > -1) ext = originalName.substring(dotIdx);
        return UUID.randomUUID().toString() + ext;
    }

    /** 디렉토리 없으면 생성 */
    public static void ensureDir(String path) {
        File dir = new File(path);
        if (!dir.exists()) dir.mkdirs();
    }
}
