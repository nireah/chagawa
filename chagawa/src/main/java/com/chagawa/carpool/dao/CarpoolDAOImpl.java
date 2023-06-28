package com.chagawa.carpool.dao;

import java.util.ArrayList;
import java.util.List;

import com.chagawa.carpool.vo.CarpoolVO;
import com.chagawa.carpool.vo.PassengerVO;
import com.chagawa.io.db.DAO;
import com.webjjang.util.PageObject;

public class CarpoolDAOImpl extends DAO implements CarpoolDAO {

	// 메서드별 용도는 CarpoolDAO 인터페이스에 주석으로 기재하였음

	@Override
	public long getTotalRow(String condition, String str1, String str2) throws Exception {
		System.out.println("CarpoolDAOImpl.getTotalRow()");
		Long totalRow = null;
		try {
			con = getConnection();
			String sql = " SELECT count(*) ";

			// 페이지를 쓰는 3가지 메서드에 따라 각각 다른 조건문 추가 - list, myDriverList, myPsgList
			if (condition.equals("list")) {
				sql += " FROM carpool c, member m WHERE c.status = '모집중' AND startRegion = ? AND arriveRegion = ? AND c.driverId = m.id ";
			} else if (condition.equals("driver")) {
				sql += " FROM carpool c, member m WHERE c.driverId = ? AND (c.status = '종료' OR c.status = '취소') AND c.driverId = m.id ";
			} else if (condition.equals("psg")) {
				sql += "FROM carpool c, member m, passenger p WHERE p.psgId = ? AND (c.status = '종료' OR c.status = '취소') AND p.psgId = m.id AND p.cpNo = c.no";
			}
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, str1); // 첫 번째 물음표에 값 세팅
			if (str2 != null)
				pstmt.setString(2, str2); // 물음표가 2개인 경우 2번도 세팅

			rs = pstmt.executeQuery();
			if (rs.next()) {
				totalRow = rs.getLong(1); // count(*)의 값을 받아와 리턴
			}
			return totalRow;
		} catch (Exception e) {
			throw e;
		} finally {
			close();
		}
	}

	@Override
	public List<CarpoolVO> list(CarpoolVO vo, PageObject pageObject) throws Exception {
		System.out.println("CarpoolDAOImpl.list()");
		List<CarpoolVO> list = null;
		try {
			con = getConnection();
			String cols = " no, id, nickname, startAddress, arriveAddress, startTimePre, arriveTimePre, price, seats, driveCount, dstarAvg, dstarCount, pfixCount ";
			String sql = " SELECT " + cols + " FROM ( ";
			sql += " SELECT rownum rnum, " + cols + " FROM ( ";
			sql += " SELECT c.no, m.id, m.nickname, c.startAddress, c.arriveAddress, c.startTimePre, c.arriveTimePre, c.price, c.seats, "
					+ " (SELECT count(*) FROM carpool WHERE driverId = m.id AND status='종료') driveCount, " // 드라이버 운행횟수
					+ " (SELECT trunc(avg(star), 2) FROM starpoint WHERE receiver = m.id) dstarAvg, " // 드라이버 평균별점
					+ " (SELECT count(*) FROM starpoint WHERE receiver = m.id) dstarCount, " // 드라이버 별점횟수"
					+ " (SELECT count(*) FROM passenger WHERE fixed = 1 AND cpNo = c.no) pfixCount " // 동승확정자 수;
					+ " FROM carpool c, member m WHERE c.status = '모집중' AND startRegion = ? AND arriveRegion = ? AND c.driverId = m.id ORDER BY c.regTime desc ";
			sql += ")) WHERE rnum BETWEEN ? AND ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, vo.getStartRegion());
			pstmt.setString(2, vo.getArriveRegion());
			pstmt.setLong(3, pageObject.getStartRow());
			pstmt.setLong(4, pageObject.getEndRow());
			rs = pstmt.executeQuery();
			while (rs.next()) {
				if (list == null)
					list = new ArrayList<>();
				CarpoolVO cvo = new CarpoolVO();
				cvo.setNo(rs.getLong("no"));
				cvo.setId(rs.getString("id"));
				cvo.setNickname(rs.getString("nickname"));
				cvo.setStartAddress(rs.getString("startAddress"));
				cvo.setArriveAddress(rs.getString("arriveAddress"));
				cvo.setStartTimePre(rs.getString("startTimePre"));
				cvo.setArriveTimePre(rs.getString("arriveTimePre"));
				cvo.setPrice(rs.getInt("price"));
				cvo.setSeats(rs.getInt("seats"));
				cvo.setDriveCount(rs.getInt("driveCount"));
				cvo.setStarAvg(rs.getDouble("dstarAvg"));
				cvo.setStarCount(rs.getInt("dstarCount"));
				cvo.setPsgFixCount(rs.getInt("pfixCount"));
				list.add(cvo);
			}
			return list;
		} catch (Exception e) {
			throw e;
		} finally {
			close();
		}
	}

	@Override
	public List<CarpoolVO> myList(String id, String isDriver, PageObject pageObject) throws Exception {
		List<CarpoolVO> list = null;
		System.out.println("CarpoolDAOImpl.myList()");
		String condition = null;
		if (isDriver.equals("driver"))
			condition = " WHERE c.driverId = ? ";
		else
			condition = ", passenger p WHERE p.psgId = ? AND c.no = p.cpNo ";
		try {
			con = getConnection();
			String cols = " no, nickname, startRegion, startAddress, arriveRegion, arriveAddress, startTime, arriveTime, price, status, seats, carModel, carNo, reviewed, star, pfixCount, pgotCount ";
			String sql = " SELECT " + cols + " FROM ( ";
			sql += " SELECT rownum rnum, " + cols + " FROM ( ";
			sql += " SELECT c.no, m.nickname, c.startRegion, c.startAddress, c.arriveRegion, c.arriveAddress, c.startTime, c.arriveTime, c.price, "
					+ " c.status, c.seats, d.carModel, d.carNo, c.star, "
					+ " (SELECT count(*) FROM passenger WHERE fixed = 1 AND cpNo = c.no) pfixCount, " // 동승확정자 수;
					+ " (SELECT count(*) FROM passenger WHERE gotin = 1 AND cpNo = c.no) pgotCount, " // 탑승자 수;
					+ " (SELECT reviewed FROM passenger WHERE cpNo=c.no AND psgId = ?) reviewed " // 내 리뷰여부
					+ " FROM carpool c, member m, driver d " + condition
					+ " AND m.id = d.id AND c.driverId = m.id AND (c.status = '종료' OR c.status = '도착' OR c.status = '취소') ORDER BY c.no desc ";
			sql += ")) WHERE rnum BETWEEN ? AND ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, id);
			pstmt.setLong(3, pageObject.getStartRow());
			pstmt.setLong(4, pageObject.getEndRow());
			System.out.println(sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				if (list == null)
					list = new ArrayList<>();
				CarpoolVO vo = new CarpoolVO();
				vo.setNo(rs.getLong("no"));
				vo.setNickname(rs.getString("nickname"));
				vo.setStartRegion(rs.getString("startRegion"));
				vo.setStartAddress(rs.getString("startAddress"));
				vo.setArriveRegion(rs.getString("arriveRegion"));
				vo.setArriveAddress(rs.getString("arriveAddress"));
				vo.setStartTime(rs.getString("startTime"));
				vo.setArriveTime(rs.getString("arriveTime"));
				vo.setPrice(rs.getInt("price"));
				vo.setStatus(rs.getString("status"));
				vo.setSeats(rs.getInt("seats"));
				vo.setCarModel(rs.getString("carModel"));
				vo.setCarNo(rs.getString("carNo"));
				vo.setReviewed(rs.getInt("reviewed"));
				vo.setStar(rs.getInt("star"));
				vo.setPsgFixCount(rs.getInt("pfixCount"));
				vo.setPsgGotCount(rs.getInt("pgotCount"));
				list.add(vo);
			}
			return list;
		} catch (Exception e) {
			throw e;
		} finally {
			close();
		}
	}

	@Override
	public List<PassengerVO> psgPerDriveList(Long cpNo) throws Exception {
		System.out.println("CarpoolDAOImpl.psgPerDriveList()");
		List<PassengerVO> list = null;
		try {
			con = getConnection();
			String sql = " SELECT m.nickname, m.profileImage, p.msg, p.status FROM member m, passenger p WHERE cpNo = ? AND m.id = p.psgId ";
			pstmt = con.prepareStatement(sql);
			pstmt.setLong(1, cpNo);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				if (list == null)
					list = new ArrayList<>();
				PassengerVO vo = new PassengerVO();
				vo.setNickname(rs.getString("nickname"));
				vo.setProfileImage(rs.getString("profileImage"));
				vo.setMsg(rs.getString("msg"));
				vo.setStatus(rs.getString("status"));
				list.add(vo);
			}
			return list;
		} catch (Exception e) {
			throw e;
		} finally {
			close();
		}
	}

	@Override
	public CarpoolVO nowDriving(String id) throws Exception {
		System.out.println("CarpoolDAOImpl.nowDriving()");
		CarpoolVO vo = null;
		try {
			con = getConnection();
			String sql = " SELECT no, driverId, status FROM carpool WHERE driverId = ? AND (status != '종료' AND status != '취소') ";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				vo = new CarpoolVO();
				vo.setNo(rs.getLong("no"));
				vo.setId(rs.getString("driverId"));
				vo.setStatus(rs.getString("status"));
			}
			return vo;
		} catch (Exception e) {
			throw e;
		} finally {
			close();
		}
	}

	@Override
	public CarpoolVO nowPsging(String id) throws Exception {
		System.out.println("CarpoolDAOImpl.nowPsging()");
		CarpoolVO vo = null;
		try {
			con = getConnection();
			String sql = " SELECT p.cpNo, c.status, p.status pstatus FROM carpool c, passenger p "
					+ " WHERE psgId = ? AND (c.status != '종료' AND c.status != '취소') AND c.no = p.cpNo ";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				vo = new CarpoolVO();
				vo.setNo(rs.getLong("cpNo"));
				vo.setStatus(rs.getString("status"));
				vo.setPstatus(rs.getString("pstatus"));
			}
			return vo;
		} catch (Exception e) {
			throw e;
		} finally {
			close();
		}
	}

	@Override
	public CarpoolVO view(Long no) throws Exception {
		System.out.println("CarpoolDAOImpl.view()");
		CarpoolVO vo = null;
		try {
			con = getConnection();
			String sql = " SELECT c.status, c.no, c.driverId, m.nickname, m.profileImage, c.startRegion, c.startAddress, c.arriveRegion, c.arriveAddress, c.startLat, c.startLng, c.arriveLat, c.arriveLng, "
					+ " c.startTimePre, c.arriveTimePre, c.startTime, c.arriveTime, c.price, c.seats, d.carModel, d.carNo, c.memo, c.star, "
					+ " (SELECT count(*) FROM carpool WHERE driverId = 'driver' AND status='종료') driveCount, " // 운행횟수
					+ " (SELECT trunc(avg(star),2) FROM starpoint WHERE receiver = m.id) dstarAvg,  " // 드라이버 평균별점
					+ " (SELECT count(*) FROM starpoint WHERE receiver = m.id) dstarCount, " // 드라이버 별점횟수
					+ " (SELECT count(*) FROM passenger WHERE fixed = 0 AND cpNo = c.no) papplCount, " // 현재 동승신청자 수
					+ " (SELECT count(*) FROM passenger WHERE fixed = 1 AND cpNo = c.no) pfixCount, " // 현재 동승확정자 수
					+ " (SELECT count(*) FROM passenger WHERE gotin = 1 AND cpNo = c.no) pgotCount, " // 현재 탑승확정자 수
					+ " (SELECT count(*) FROM passenger WHERE arrived = 1 AND cpNo = c.no) parrCount " // 현재 도착확정자 수
					+ " FROM carpool c, member m, driver d WHERE c.no = ? AND c.driverId = m.id AND m.id = d.id ";
			pstmt = con.prepareStatement(sql);
			pstmt.setLong(1, no);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				vo = new CarpoolVO();
				vo.setStatus(rs.getString("status"));
				vo.setNo(rs.getLong("no"));
				vo.setId(rs.getString("driverId"));
				vo.setNickname(rs.getString("nickname"));
				vo.setProfileImage(rs.getString("profileImage"));
				vo.setStartRegion(rs.getString("startRegion"));
				vo.setStartAddress(rs.getString("startAddress"));
				vo.setArriveRegion(rs.getString("arriveRegion"));
				vo.setArriveAddress(rs.getString("arriveAddress"));
				vo.setStartLat(rs.getDouble("startLat"));
				vo.setStartLng(rs.getDouble("startLng"));
				vo.setArriveLat(rs.getDouble("arriveLat"));
				vo.setArriveLng(rs.getDouble("arriveLng"));
				vo.setStartTimePre(rs.getString("startTimePre"));
				vo.setArriveTimePre(rs.getString("arriveTimePre"));
				vo.setStartTime(rs.getString("startTime"));
				vo.setArriveTime(rs.getString("arriveTime"));
				vo.setPrice(rs.getInt("price"));
				vo.setSeats(rs.getInt("seats"));
				vo.setCarModel(rs.getString("carModel"));
				vo.setCarNo(rs.getString("carNo"));
				vo.setMemo(rs.getString("memo"));
				vo.setStar(rs.getInt("star"));
				vo.setDriveCount(rs.getInt("driveCount"));
				vo.setStarAvg(rs.getDouble("dstarAvg"));
				vo.setStarCount(rs.getInt("dstarCount"));
				vo.setPsgAppCount(rs.getInt("papplCount"));
				vo.setPsgFixCount(rs.getInt("pfixCount"));
				vo.setPsgGotCount(rs.getInt("pgotCount"));
				vo.setPsgArrCount(rs.getInt("parrCount"));
			}
			return vo;
		} catch (Exception e) {
			throw e;
		} finally {
			close();
		}
	}

	@Override
	public List<PassengerVO> psgList(Long cpNo) throws Exception {
		System.out.println("CarpoolDAOImpl.psgList()");
		List<PassengerVO> list = null;
		try {
			con = getConnection();

			String sql = " SELECT m.id, m.nickname, m.profileImage, p.msg, p.appTime, p.status, p.fixed, p.gotIn, p.arrived, p.star, "
					+ " (SELECT count(*) FROM passenger WHERE psgId = p.psgId AND status='종료') psgCount, " // 동승횟수
					+ " (SELECT trunc(avg(star), 2) FROM starpoint WHERE receiver = p.psgId) pstarAvg, " // 평균별점
					+ " (SELECT count(*) FROM starpoint WHERE receiver = p.psgId) pstarCount " // 별점횟수
					+ " FROM passenger p, member m WHERE cpNo = ? AND p.psgId = m.id ";

			pstmt = con.prepareStatement(sql);
			pstmt.setLong(1, cpNo);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				if (list == null)
					list = new ArrayList<>();
				PassengerVO vo = new PassengerVO();
				vo.setId(rs.getString("id"));
				vo.setNickname(rs.getString("nickname"));
				vo.setProfileImage(rs.getString("profileImage"));
				vo.setMsg(rs.getString("msg"));
				vo.setAppTime(rs.getString("appTime"));
				vo.setStatus(rs.getString("status"));
				vo.setFixed(rs.getInt("fixed"));
				vo.setGotIn(rs.getInt("gotIn"));
				vo.setArrived(rs.getInt("arrived"));
				vo.setStar(rs.getInt("star"));
				vo.setPsgCount(rs.getInt("psgCount"));
				vo.setStarAvg(rs.getDouble("pstarAvg"));
				vo.setStarCount(rs.getInt("pstarCount"));
				list.add(vo);
			}
			return list;
		} catch (Exception e) {
			throw e;
		} finally {
			close();
		}
	}

	@Override
	public Integer write(CarpoolVO vo) throws Exception {
		System.out.println("CarpoolDAOImpl.write()");
		try {
			con = getConnection();
			String sql = " INSERT INTO carpool (no, driverId, startRegion, startAddress, arriveRegion, arriveAddress, startLat, startLng, arriveLat, arriveLng, startTimePre, arriveTimePre, price, seats, memo) "
					+ " VALUES (carpool_seq.NEXTVAL, ?, ?, ?, ?, ?, ?, ?, ?, ?, to_date(?,'yyyy-mm-dd hh24:mi'), to_date(?,'yyyy-mm-dd hh24:mi'), ?, ?, ?) ";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, vo.getId());
			pstmt.setString(2, vo.getStartRegion());
			pstmt.setString(3, vo.getStartAddress());
			pstmt.setString(4, vo.getArriveRegion());
			pstmt.setString(5, vo.getArriveAddress());
			pstmt.setDouble(6, vo.getStartLat());
			pstmt.setDouble(7, vo.getStartLng());
			pstmt.setDouble(8, vo.getArriveLat());
			pstmt.setDouble(9, vo.getArriveLng());
			pstmt.setString(10, vo.getStartTimePre());
			pstmt.setString(11, vo.getArriveTimePre());
			pstmt.setInt(12, vo.getPrice());
			pstmt.setInt(13, vo.getSeats());
			pstmt.setString(14, vo.getMemo());
			return pstmt.executeUpdate();
		} catch (Exception e) {
			throw e;
		} finally {
			close();
		}
	}

	@Override
	public Integer apply(PassengerVO vo) throws Exception {
		System.out.println("CarpoolDAOImpl.apply()");
		try {
			con = getConnection();
			String sql = " INSERT INTO passenger (cpNo, psgId, msg) VALUES(?, ?, ?) ";
			pstmt = con.prepareStatement(sql);
			pstmt.setLong(1, vo.getCpNo());
			pstmt.setString(2, vo.getId());
			pstmt.setString(3, vo.getMsg());
			return pstmt.executeUpdate();
		} catch (Exception e) {
			throw e;
		} finally {
			close();
		}
	}

	@Override
	public Integer cancelApply(PassengerVO vo) throws Exception {
		System.out.println("CarpoolDAOImpl.cancelApply()");
		try {
			con = getConnection();
			String sql = " DELETE FROM passenger WHERE cpNo = ? AND psgId = ? ";
			pstmt = con.prepareStatement(sql);
			pstmt.setLong(1, vo.getCpNo());
			pstmt.setString(2, vo.getId());
			return pstmt.executeUpdate();
		} catch (Exception e) {
			throw e;
		} finally {
			close();
		}
	}

	@Override
	public Integer updateCpStatus(CarpoolVO vo) throws Exception {
		System.out.println("CarpoolDAOImpl.updateCpStatus()");
		try {
			con = getConnection();
			String status = vo.getStatus();
			String sql = " UPDATE carpool SET status = ? ";
			if (status.equals("운행중")) {
				sql += " , startTime = sysdate "; // 운행중으로 변경 시 출발시간 등록
			} else if (status.equals("도착")) {
				sql += " , arriveTime = sysdate "; // 도착으로 변경 시 도착시간 등록
			}
			sql += " WHERE no = ? ";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, vo.getStatus());
			pstmt.setLong(2, vo.getNo());
			return pstmt.executeUpdate();
		} catch (Exception e) {
			throw e;
		} finally {
			close();
		}
	}

	@Override
	public Integer delUnfixed(Long cpNo) throws Exception {
		System.out.println("CarpoolDAOImpl.delUnfixed()");
		try {
			con = getConnection();
			String sql = " DELETE FROM passenger WHERE cpNo = ? AND fixed = 0 ";
			pstmt = con.prepareStatement(sql);
			pstmt.setLong(1, cpNo);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			throw e;
		} finally {
			close();
		}
	}

	@Override
	public Integer updatePsgStatus(PassengerVO vo) throws Exception {
		System.out.println("CarpoolDAOImpl.updatePsgStatus()");
		try {
			con = getConnection();
			String status = vo.getStatus();
			String sql = " UPDATE passenger SET status = ? ";
			if (status.equals("확정")) { // 확정, 탑승, 도착시 각 사람의 해당여부 변경
				sql += " , fixed = 1 ";
			} else if (status.equals("탑승")) {
				sql += " , gotIn = 1 ";
			} else if (status.equals("도착")) {
				sql += " , arrived = 1 ";
			}

			sql += " WHERE cpNo = ? ";

			if (status.equals("탑승")) {
				sql += " AND psgId = ? AND status != '미탑승' "; // 추가 조건 : 입력한 동승자만 변경, 출발하지 않았어야 함
			} else if (status.equals("도착") || status.equals("확정")) {
				sql += " AND psgId = ? "; // 추가 조건 : 입력한 동승자만 변경
			} else if (status.equals("종료")) {
				sql += " AND status = '도착' "; // 추가 조건 : 운행종료 시 '도착' 상태인 사람만 변경
			} else if (status.equals("미탑승")) {
				sql += " AND gotIn = 0 "; // 추가 조건 : 출발 시 gotIn이 0인 사람만 미탑승으로 변경
			}
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, vo.getStatus());
			pstmt.setLong(2, vo.getCpNo());
			if (status.equals("탑승") || status.equals("도착") || status.equals("확정")) {
				pstmt.setString(3, vo.getId());
			}
			return pstmt.executeUpdate();
		} catch (Exception e) {
			throw e;
		} finally {
			close();
		}
	}

	@Override
	public Integer uncheckedPsg(Long cpNo) throws Exception {
		System.out.println("CarpoolDAOImpl.uncheckedPsg()");
		Integer result = null;
		try {
			con = getConnection();

			String sql = " SELECT count(*) FROM passenger WHERE cpNo = ? AND gotin = 1 AND arrived = 0 ";

			pstmt = con.prepareStatement(sql);
			pstmt.setLong(1, cpNo);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				result = rs.getInt(1);
			}
			return result;
		} catch (Exception e) {
			throw e;
		} finally {
			close();
		}
	}

	@Override
	public List<Long> unreviewedCpNo(String id) throws Exception {
		System.out.println("CarpoolDAOImpl.unreviewedCpNo()");
		List<Long> list = null;
		try {
			con = getConnection();
			// 운행기록 중 리뷰 미입력한 것 찾기
			String sql = " SELECT no FROM carpool WHERE driverId = ? AND reviewed = 0 ";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				if (list == null)
					list = new ArrayList<>();
				list.add(rs.getLong("no"));
			}
			// 동승기록 중 리뷰 미입력한 것 찾기
			sql = " SELECT cpNo FROM passenger WHERE psgId = ? AND reviewed = 0 ";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				if (list == null)
					list = new ArrayList<>();
				list.add(rs.getLong("cpNo"));
			}
			return list;
		} catch (Exception e) {
			throw e;
		} finally {
			close();
		}
	}

	@Override
	public Integer review(CarpoolVO vo) throws Exception {
		System.out.println("CarpoolDAOImpl.review()");
		Integer result = 0;
		String col = vo.getMemo(); // "reviewed" 또는 "star" 넣어서 보낼 것
		int reviewed = vo.getReviewed();
		try {
			con = getConnection();
			// 드라이버인 경우 result + 1
			String sql = " UPDATE carpool SET " + col + " = " + reviewed + " WHERE no = ? AND driverId = ? ";
			pstmt = con.prepareStatement(sql);
			pstmt.setLong(1, vo.getNo());
			pstmt.setString(2, vo.getId());
			result += pstmt.executeUpdate();

			System.out.println(sql);
			System.out.println(col);
			System.out.println(reviewed);
			System.out.println(vo);

			// 동승자인 경우 result + 1
			sql = " UPDATE passenger SET " + col + " = " + reviewed + " WHERE cpNo = ? AND psgId = ? ";
			pstmt = con.prepareStatement(sql);
			pstmt.setLong(1, vo.getNo());
			pstmt.setString(2, vo.getId());
			result += pstmt.executeUpdate();

			System.out.println(sql);
			System.out.println(col);
			System.out.println(reviewed);
			System.out.println(vo);

			return result; // 1이 반환되어야 정상
		} catch (Exception e) {
			throw e;
		} finally {
			close();
		}
	}

}
